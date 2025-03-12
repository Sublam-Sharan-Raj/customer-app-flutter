import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_closet/app_colors.dart';
import 'package:insta_closet/bloc/address/address_bloc.dart';
import 'package:insta_closet/bloc/auth/auth_bloc.dart';
import 'package:insta_closet/bloc/location/location_bloc.dart';
import 'package:insta_closet/models/order.dart';
import 'package:insta_closet/validator.dart';
import 'package:insta_closet/widgets/custom_input_field.dart';

class AddOrEditAddress extends StatefulWidget {
  const AddOrEditAddress({super.key, this.type, this.address});

  final String? type;
  final Address? address;

  @override
  State<AddOrEditAddress> createState() => _AddOrEditAddressState();
}

class _AddOrEditAddressState extends State<AddOrEditAddress> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController? streetNumberController;
  TextEditingController? streetNameController;
  TextEditingController? cityController;
  TextEditingController? stateController;
  TextEditingController? pincodeController;
  TextEditingController? typeController;

  @override
  void initState() {
    super.initState();

    if (widget.type == "edit" && widget.address != null) {
      context
          .read<AddressBloc>()
          .add(UpdateArea(area: widget.address!.city.toString()));
      context
          .read<AddressBloc>()
          .add(UpdatePincode(pincode: widget.address!.pincode.toString()));
      context
          .read<AddressBloc>()
          .add(UpdateLine(line: widget.address!.line.toString()));
      context
          .read<AddressBloc>()
          .add(UpdateLandmark(landmark: widget.address!.landmark.toString()));
      context
          .read<AddressBloc>()
          .add(UpdateState(state: widget.address!.state.toString()));

      context.read<AddressBloc>().add(UpdateType(type: widget.address!.type));
      setState(() {
        selectedChip = widget.address!.type ?? "Home";
      });
      pincodeController =
          TextEditingController(text: widget.address!.pincode.toString());
      streetNumberController =
          TextEditingController(text: widget.address!.line.toString());
      streetNameController =
          TextEditingController(text: widget.address!.landmark.toString());
      cityController =
          TextEditingController(text: widget.address!.city.toString());
      stateController = TextEditingController(
          text: widget.address!.state != "null" ? widget.address!.state : "");
    } else {
      pincodeController = TextEditingController();
      streetNameController = TextEditingController();
      streetNumberController = TextEditingController();
      cityController = TextEditingController();
      stateController = TextEditingController();
      typeController = TextEditingController();
      context.read<AddressBloc>().add(UpdateType(type: "Home"));
      context.read<AddressBloc>().add(ResetAddress());
      setState(() {
        selectedChip = "Home";
      });
    }

    // Add listeners to update button enable/disable state on field change
    streetNumberController!.addListener(_checkFormValidity);
    streetNameController!.addListener(_checkFormValidity);
    cityController!.addListener(_checkFormValidity);
    stateController!.addListener(_checkFormValidity);
    pincodeController!.addListener(_checkFormValidity);
  }

  @override
  void dispose() {
    streetNumberController!.removeListener(_checkFormValidity);
    streetNameController!.removeListener(_checkFormValidity);
    cityController!.removeListener(_checkFormValidity);
    stateController!.removeListener(_checkFormValidity);
    pincodeController!.removeListener(_checkFormValidity);
    super.dispose();
  }

  bool _isFormValid() {
    return streetNumberController!.text.isNotEmpty &&
        streetNameController!.text.isNotEmpty &&
        cityController!.text.isNotEmpty &&
        stateController!.text.isNotEmpty &&
        pincodeController!.text.isNotEmpty;
  }

  String? selectedChip = 'Home';
  void _checkFormValidity() {
    setState(() {}); // Trigger a rebuild to update button state
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Address"),
      ),
      body: SingleChildScrollView(
        child: BlocListener<AddressBloc, AddressState>(
          listener: (context, state) {
            if (state.hasPinChanged && pincodeController!.text != "") {
              print("${state.area}, ${state.state}");
              cityController!.text = state.area;
              stateController!.text = state.state;
            }
          },
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ChoiceChip(
                          label: Text('Home'),
                          selected: selectedChip == 'Home',
                          selectedColor: AppColors.secondary,
                          onSelected: (selected) {
                            setState(() {
                              selectedChip = selected ? 'Home' : null;
                            });
                            context
                                .read<AddressBloc>()
                                .add(UpdateType(type: 'Home'));
                          },
                        ),
                        SizedBox(width: 10),
                        ChoiceChip(
                          label: Text('Office'),
                          selected: selectedChip == 'Office',
                          selectedColor: AppColors.secondary,
                          onSelected: (selected) {
                            setState(() {
                              selectedChip = selected ? 'Office' : null;
                            });
                            context
                                .read<AddressBloc>()
                                .add(UpdateType(type: 'Office'));
                          },
                        ),
                        SizedBox(width: 10),
                        ChoiceChip(
                          label: Text('Other'),
                          selected: selectedChip == 'Other',
                          selectedColor: AppColors.secondary,
                          onSelected: (selected) {
                            setState(() {
                              selectedChip = selected ? 'Other' : null;
                            });
                            context
                                .read<AddressBloc>()
                                .add(UpdateType(type: 'Other'));
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomInputField(
                      labelTextEnabled: true,
                      hint: 'Street Number',
                      controller: streetNumberController!,
                      validator: Validator.valueExists,
                      onValueChanged: (val) {
                        context.read<AddressBloc>().add(UpdateLine(line: val));
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomInputField(
                      labelTextEnabled: true,
                      hint: 'Street Name',
                      controller: streetNameController!,
                      validator: Validator.valueExists,
                      onValueChanged: (val) {
                        context
                            .read<AddressBloc>()
                            .add(UpdateLandmark(landmark: val));
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomInputField(
                      labelTextEnabled: true,
                      hint: 'Pincode',
                      controller: pincodeController!,
                      validator: Validator.valueExists,
                      onValueChanged: (val) {
                        context
                            .read<AddressBloc>()
                            .add(UpdatePincode(pincode: val));
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomInputField(
                      labelTextEnabled: true,
                      hint: 'City',
                      readOnly: true,
                      controller: cityController!,
                      validator: Validator.valueExists,
                      // onValueChanged: (val) {
                      //   context.read<AddressBloc>().add(UpdateArea(area: val));
                      // },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomInputField(
                      labelTextEnabled: true,
                      hint: 'State',
                      readOnly: true,
                      controller: stateController!,
                      validator: Validator.valueExists,
                      // onValueChanged: (val) {
                      //   context
                      //       .read<AddressBloc>()
                      //       .add(UpdateState(state: val));
                      // },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isFormValid()
                            ? () {
                                final userId = (context.read<AuthBloc>().state)
                                    .auth!
                                    .user!
                                    .id;
                                BlocProvider.of<AddressBloc>(context)
                                    .add(SaveAddress(
                                  userId: userId,
                                  context: context,
                                  lat: context
                                      .read<LocationBloc>()
                                      .state
                                      .latitude,
                                  long: context
                                      .read<LocationBloc>()
                                      .state
                                      .longitude,
                                ));
                              }
                            : null, // Disable button if form is not valid
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          textStyle: const TextStyle(fontSize: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text('SAVE',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
