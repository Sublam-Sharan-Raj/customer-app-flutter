part of 'address_bloc.dart';

@immutable
sealed class AddressEvent {}

class FetchAddressList extends AddressEvent {
  final String? userId;

  FetchAddressList({this.userId});
}

class SaveAddress extends AddressEvent {
  final String? userId;

  final double? lat;
  final double? long;

  final BuildContext context;

  SaveAddress({this.lat, this.long, this.userId, required this.context});
}

class UpdatePincode extends AddressEvent {
  final String pincode;
  UpdatePincode({
    required this.pincode,
  });
}

class ResetAddress extends AddressEvent {
  ResetAddress();
}

class UpdateLandmark extends AddressEvent {
  final String landmark;
  UpdateLandmark({
    required this.landmark,
  });
}

class UpdateLine extends AddressEvent {
  final String line;
  UpdateLine({
    required this.line,
  });
}

class UpdateArea extends AddressEvent {
  final String area;
  UpdateArea({
    required this.area,
  });
}

class UpdateState extends AddressEvent {
  final String state;
  UpdateState({
    required this.state,
  });
}

class UpdateType extends AddressEvent {
  final String? type;
  UpdateType({
    required this.type,
  });
}

class SetAddressItem extends AddressEvent {
  final Address? address;
  SetAddressItem({
    required this.address,
  });
}

class HandleSelectedAddress extends AddressEvent {
  final Address? selectedAddress;
  HandleSelectedAddress(this.selectedAddress);
}
