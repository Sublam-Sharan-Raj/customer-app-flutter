// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'address_bloc.dart';

class AddressState {
  final List<Address>? addressList;
  final Address? selectedAddress;
  final bool? addressLoading;
  final bool? isaddressError;
  final String pincode;
  final String landmark;
  final String line;
  final String area;
  final String state;
  final String type;
  final bool hasPinChanged;

  AddressState(
      {this.addressLoading = false,
      this.isaddressError = false,
      this.hasPinChanged = false,
      this.addressList = const [],
      this.line = '',
      this.area = '',
      this.pincode = '',
      this.state = '',
      this.landmark = '',
      this.type = '',
      this.selectedAddress = const Address()});

  factory AddressState.reset() => AddressState();

  AddressState copyWith(
      {List<Address>? addressList,
      Address? selectedAddress,
      bool? addressLoading,
      bool? isaddressError,
      String? pincode,
      String? landmark,
      String? line,
      String? area,
      String? state,
      String? type,
      bool? hasPinChanged}) {
    return AddressState(
        addressList: addressList ?? this.addressList,
        selectedAddress: selectedAddress ?? this.selectedAddress,
        addressLoading: addressLoading ?? this.addressLoading,
        isaddressError: isaddressError ?? this.isaddressError,
        pincode: pincode ?? this.pincode,
        line: line ?? this.line,
        landmark: landmark ?? this.landmark,
        area: area ?? this.area,
        state: state ?? this.state,
        type: type ?? this.type,
        hasPinChanged: hasPinChanged ?? this.hasPinChanged);
  }
}
