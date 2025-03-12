import 'package:insta_closet/models/order.dart';

class LocationState {
  final bool isLoading;
  final double? latitude;
  final double? longitude;
  final Address? address;
  final String? errorMessage;
  final bool locationStateLoaded;
  final bool locationStateError;

  LocationState(
      {this.isLoading = false,
      this.latitude,
      this.longitude,
      this.address,
      this.errorMessage,
      this.locationStateLoaded = false,
      this.locationStateError = false});

  // Factory methods to easily create instances for each state
  factory LocationState.initial() {
    return LocationState(
        isLoading: false,
        latitude: null,
        longitude: null,
        address: null,
        errorMessage: null,
        locationStateLoaded: false,
        locationStateError: false);
  }

  factory LocationState.loading() {
    return LocationState(isLoading: true);
  }

  factory LocationState.loaded(
      double latitude, double longitude, Address address) {
    return LocationState(
        isLoading: false,
        latitude: latitude,
        longitude: longitude,
        address: address,
        errorMessage: null,
        locationStateLoaded: true,
        locationStateError: false);
  }

  factory LocationState.error(String message) {
    return LocationState(
        isLoading: false,
        latitude: null,
        longitude: null,
        address: null,
        errorMessage: message,
        locationStateError: true,
        locationStateLoaded: false);
  }
}
