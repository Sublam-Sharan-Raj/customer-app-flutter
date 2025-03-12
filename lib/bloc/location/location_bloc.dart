import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:insta_closet/bloc/location/location_event.dart';
import 'package:insta_closet/bloc/location/location_state.dart';
import 'package:insta_closet/models/order.dart' as order;

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationState.initial()) {
    on<FetchLocation>(_onFetchLocation);
  }

  Future<void> _onFetchLocation(
      FetchLocation event, Emitter<LocationState> emit) async {
    emit(LocationState.loading());

    try {
      // Check and request permissions
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Show dialog to enable location services
        await _showEnableLocationDialog(event.context!);
        // Re-check if location services are enabled after the dialog
        serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          throw Exception("Location services are still disabled.");
        }
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception("Location permissions are denied.");
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
            "Location permissions are permanently denied, we cannot request permissions.");
      }

      final LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
      Position position = await Geolocator.getCurrentPosition(
          locationSettings: locationSettings);

      // Reverse geocode to get address
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      print("$place, place");
      order.Address address = order.Address(
        line: place.street ?? '',
        landmark: place.subLocality ?? '',
        city: place.locality ?? '',
        state: place.administrativeArea ?? "",
        pincode: place.postalCode != null ? int.parse(place.postalCode!) : null,
      );

      emit(
          LocationState.loaded(position.latitude, position.longitude, address));
    } catch (e) {
      print("Error: $e");
      emit(LocationState.error(e.toString()));
    }
  }

  Future<void> _showEnableLocationDialog(BuildContext context) async {
    // Access the context using your application's mechanism
/* Pass the context appropriately */

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enable Location Services"),
          content: Text(
              "Location services are disabled. Please enable them in your device settings."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                if (context.mounted) {
                  await Geolocator.openLocationSettings();
                  Navigator.of(context).pop();
                }
                // Redirect user to location settings
              },
              child: Text("Enable"),
            ),
          ],
        );
      },
    );
  }
}
