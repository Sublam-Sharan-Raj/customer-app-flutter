import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:insta_closet/bad_request.dart';
import 'package:insta_closet/constants.dart';
import 'package:insta_closet/models/address.dart';
import 'package:insta_closet/models/pincode.dart';
import 'package:insta_closet/services/user_service.dart';
import 'package:http/http.dart' as http;
import 'package:insta_closet/widgets/loading.dart';
part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressState.reset()) {
    final UserService userService = UserService();
    on<AddressEvent>((event, emit) async {
      if (event is FetchAddressList) {
        emit(AddressState(addressLoading: true, isaddressError: false));
        try {
          final response = await userService.fetchAddresses(event.userId!);
          final categoryMap = response as List<dynamic>;
          final data = categoryMap.map((e) {
            return Address.fromJson(e);
          }).toList();

          emit(AddressState(
              addressList: data,
              selectedAddress: data[0],
              addressLoading: false,
              isaddressError: false));
        } catch (e) {
          emit(AddressState(addressLoading: false, isaddressError: true));
        }
      }
      if (event is SaveAddress) {
        if (event.context.mounted) {
          LoadingOverlay.show(event.context);
        }

        try {
          final payload = {
            "type": state.type,
            "line": state.line,
            "state": state.state,
            "city": state.area,
            "landmark": state.landmark,
            "pincode": state.pincode,
            "geo_coordinates": {"latitude": event.lat, "longitude": event.long}
          };

          final response =
              await userService.saveAddress(event.userId!, payload);

          if (response.statusCode == 200 || response.statusCode == 201) {
            if (event.context.mounted) {
              BlocProvider.of<AddressBloc>(event.context)
                  .add(FetchAddressList(userId: event.userId));
              LoadingOverlay.hide();
              Navigator.pop(event.context);
              ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
                content: Text('Address Saved Successfully'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              ));
            }
          } else {
            if (event.context.mounted) {
              LoadingOverlay.hide();
              ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
                content: Text('Failed to save address'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              ));
            }
          }
        } on BadRequest catch (error) {
          if (event.context.mounted) {
            LoadingOverlay.hide();
            ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
              content: Text('${error.errors![error.errors!.keys.toList()[0]]}'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ));
          }
        } on Exception catch (error) {
          if (event.context.mounted) {
            LoadingOverlay.hide();
            ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
              content: Text(error.toString()),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ));
          }
        }
      }

      if (event is UpdateLine) {
        emit(state.copyWith(
          line: event.line,
        ));
      }
      if (event is UpdateArea) {
        emit(state.copyWith(
          area: event.area,
        ));
      }
      if (event is UpdateLandmark) {
        emit(state.copyWith(landmark: event.landmark));
      }
      if (event is UpdatePincode) {
        final oldPincode = state.pincode;
        emit(state.copyWith(pincode: event.pincode));

        if (event.pincode.length == 6 && oldPincode != event.pincode) {
          final response = await http.get(
            Uri.parse(
              Constants.printf(Constants.pincodeUrl, {'pin': event.pincode})!,
            ),
          );

          if (response.statusCode == 200) {
            print("${response.body}, body");

            final jsonResponse = json.decode(response.body) as List<dynamic>;

            // Map the JSON list to your Pincode model
            final pincodeResponse = jsonResponse.map((e) {
              return Pincode.fromJson(e);
            }).toList();
            // final jsonResponse = jsonDecode(response.body);
            // final pincodeResponse = Pincode.fromJson(response.body);
            print("$pincodeResponse, pincodeResponse");
            if (pincodeResponse.first.status == 'Success' &&
                pincodeResponse.first.postOffice != null &&
                pincodeResponse.first.postOffice!.isNotEmpty) {
              final firstPostOffice = pincodeResponse.first.postOffice!.first;

              emit(
                state.copyWith(
                  state: Constants.toTitleCase(firstPostOffice.state ?? ''),
                  area: Constants.toTitleCase(firstPostOffice.name ?? ''),
                  hasPinChanged: true,
                ),
              );
            } else {
              emit(state.copyWith(state: '', area: '', hasPinChanged: false));
            }
          } else {
            emit(state.copyWith(state: '', area: '', hasPinChanged: false));
          }
        }
      }

      if (event is UpdateState) {
        emit(state.copyWith(state: event.state));
      }
      if (event is UpdateType) {
        emit(state.copyWith(
          type: event.type,
        ));
      }

      if (event is ResetAddress) {
        emit(state.copyWith(state: '', area: "", hasPinChanged: false));
      }

      if (event is HandleSelectedAddress) {
        print("${event.selectedAddress}, address");
        emit(AddressState(selectedAddress: event.selectedAddress));
      }
    });
  }
}
