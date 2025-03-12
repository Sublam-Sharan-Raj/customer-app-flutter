import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_closet/app_colors.dart';
import 'package:insta_closet/bloc/address/address_bloc.dart';
import 'package:insta_closet/bloc/auth/auth_bloc.dart';
import 'package:insta_closet/bloc/location/location_bloc.dart';
import 'package:insta_closet/bloc/location/location_event.dart';

import 'package:insta_closet/bloc/location/location_state.dart';
import 'package:insta_closet/models/address.dart';
import 'package:insta_closet/models/order.dart' as order;
import 'package:insta_closet/screens/add_or_edit_address.dart';
import 'package:insta_closet/widgets/loading.dart';

class Location extends StatefulWidget {
  const Location({super.key, required this.onLocationSelected});

  final VoidCallback onLocationSelected;
  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  void initState() {
    super.initState();
    final userId = (context.read<AuthBloc>().state).auth!.user!.id;
    BlocProvider.of<AddressBloc>(context).add(FetchAddressList(userId: userId));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: BlocConsumer<LocationBloc, LocationState>(
        listener: (context, state) {
          if (state.isLoading) {
            LoadingOverlay.show(context);
          } else if (state.locationStateLoaded) {
            LoadingOverlay.hide();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddOrEditAddress(
                  type: "edit",
                  address: state.address,
                ),
              ),
            );
          } else if (state.locationStateError) {
            LoadingOverlay.hide();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.errorMessage ?? "unknown error occured")),
            );
          } else {
            LoadingOverlay.hide();
          }
        },
        builder: (context, state) {
          return BlocBuilder<LocationBloc, LocationState>(
            builder: (context, state) {
              return Column(
                children: [
                  LocationItem(
                    icon: Icons.location_on_outlined,
                    title: "Use the live location",
                    description: "Allows you to share your real-time location",
                    showAction: true,
                    actionTitle: "Enable",
                    onActionPressed: () {
                      BlocProvider.of<LocationBloc>(context)
                          .add(FetchLocation(context: context));
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Select a saved address",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const AddOrEditAddress()),
                          );
                        },
                        child: Text(
                          "Add New",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(
                                  color: AppColors.secondary,
                                  fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  BlocConsumer<AddressBloc, AddressState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      if (state.addressList!.isEmpty) {
                        return SizedBox(
                          height: 200,
                          child: Center(
                              child: Text(
                                  "No addresses found. Add a new address.")),
                        );
                      }
                      return SizedBox(
                        height: 200,
                        child: ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: state.addressList!.length,
                          itemBuilder: (context, index) {
                            return LocationItem(
                              showEdit: true,
                              existAddress: true,
                              onLocationSelected: widget.onLocationSelected,
                              icon: state.addressList![index].type == "Home"
                                  ? Icons.home_outlined
                                  : Icons.home_work_outlined,
                              title: state.addressList![index].type!,
                              address: state.addressList![index],
                              description:
                                  '${state.addressList![index].line!}, ${state.addressList![index].landmark}, ${state.addressList![index].pincode}',
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                                height: 10); // or any custom widget
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const LocationItem(
                    icon: Icons.search_outlined,
                    title: "Search the location manually",
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class LocationItem extends StatelessWidget {
  const LocationItem(
      {super.key,
      required this.title,
      required this.icon,
      this.description = "",
      this.showAction = false,
      this.onActionPressed,
      this.actionTitle = "",
      this.address = const Address(),
      this.onLocationSelected,
      this.existAddress = false,
      this.showEdit = false});

  final String title;
  final IconData icon;
  final String? description;
  final bool showAction;
  final VoidCallback? onActionPressed;
  final String? actionTitle;
  final Address? address;
  final VoidCallback? onLocationSelected;
  final bool? existAddress;
  final bool? showEdit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (existAddress!) {
          BlocProvider.of<AddressBloc>(context)
              .add((HandleSelectedAddress(address)));
          onLocationSelected!();
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(50)),
        padding: const EdgeInsets.all(6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppColors.red,
              size: 30,
            ),
            // SvgPicture.asset(
            //   Constants.appleIcon,
            //   height: 40,
            //   width: 40,
            // ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  Visibility(
                    visible: description != "",
                    child: const SizedBox(
                      height: 4,
                    ),
                  ),
                  Visibility(
                    visible: description != "",
                    child: Text(description ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(fontSize: 10)),
                  )
                ],
              ),
            ),

            Visibility(
              visible: showAction,
              child: ElevatedButton(
                  onPressed: onActionPressed,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary),
                  child: Text(
                    actionTitle ?? "",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.white),
                  )),
            ),
            Visibility(
              visible: showEdit!,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddOrEditAddress(
                            type: "edit",
                            address: order.Address(
                                type: address!.type,
                                line: address!.line,
                                landmark: address!.landmark,
                                city: "",
                                pincode: address!.pincode),
                          )));
                },
                child: Icon(
                  Icons.edit,
                  size: 20,
                  color: AppColors.secondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
