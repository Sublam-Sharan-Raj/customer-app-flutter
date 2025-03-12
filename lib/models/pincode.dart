// To parse this JSON data, do
//
//     final pincode = pincodeFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'pincode.freezed.dart';
part 'pincode.g.dart';

List<Pincode> pincodeFromJson(String str) =>
    List<Pincode>.from(json.decode(str).map((x) => Pincode.fromJson(x)));

String pincodeToJson(List<Pincode> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@freezed
class Pincode with _$Pincode {
  const factory Pincode({
    @JsonKey(name: "Message") String? message,
    @JsonKey(name: "Status") String? status,
    @JsonKey(name: "PostOffice") List<PostOffice>? postOffice,
  }) = _Pincode;

  factory Pincode.fromJson(Map<String, dynamic> json) =>
      _$PincodeFromJson(json);
}

@freezed
class PostOffice with _$PostOffice {
  const factory PostOffice({
    @JsonKey(name: "Name") String? name,
    @JsonKey(name: "Description") dynamic description,
    @JsonKey(name: "BranchType") String? branchType,
    @JsonKey(name: "DeliveryStatus") String? deliveryStatus,
    @JsonKey(name: "Circle") String? circle,
    @JsonKey(name: "District") String? district,
    @JsonKey(name: "Division") String? division,
    @JsonKey(name: "Region") String? region,
    @JsonKey(name: "Block") String? block,
    @JsonKey(name: "State") String? state,
    @JsonKey(name: "Country") String? country,
    @JsonKey(name: "Pincode") String? pincode,
  }) = _PostOffice;

  factory PostOffice.fromJson(Map<String, dynamic> json) =>
      _$PostOfficeFromJson(json);
}
