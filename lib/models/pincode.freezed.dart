// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pincode.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Pincode _$PincodeFromJson(Map<String, dynamic> json) {
  return _Pincode.fromJson(json);
}

/// @nodoc
mixin _$Pincode {
  @JsonKey(name: "Message")
  String? get message => throw _privateConstructorUsedError;
  @JsonKey(name: "Status")
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: "PostOffice")
  List<PostOffice>? get postOffice => throw _privateConstructorUsedError;

  /// Serializes this Pincode to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Pincode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PincodeCopyWith<Pincode> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PincodeCopyWith<$Res> {
  factory $PincodeCopyWith(Pincode value, $Res Function(Pincode) then) =
      _$PincodeCopyWithImpl<$Res, Pincode>;
  @useResult
  $Res call(
      {@JsonKey(name: "Message") String? message,
      @JsonKey(name: "Status") String? status,
      @JsonKey(name: "PostOffice") List<PostOffice>? postOffice});
}

/// @nodoc
class _$PincodeCopyWithImpl<$Res, $Val extends Pincode>
    implements $PincodeCopyWith<$Res> {
  _$PincodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Pincode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? status = freezed,
    Object? postOffice = freezed,
  }) {
    return _then(_value.copyWith(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      postOffice: freezed == postOffice
          ? _value.postOffice
          : postOffice // ignore: cast_nullable_to_non_nullable
              as List<PostOffice>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PincodeImplCopyWith<$Res> implements $PincodeCopyWith<$Res> {
  factory _$$PincodeImplCopyWith(
          _$PincodeImpl value, $Res Function(_$PincodeImpl) then) =
      __$$PincodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "Message") String? message,
      @JsonKey(name: "Status") String? status,
      @JsonKey(name: "PostOffice") List<PostOffice>? postOffice});
}

/// @nodoc
class __$$PincodeImplCopyWithImpl<$Res>
    extends _$PincodeCopyWithImpl<$Res, _$PincodeImpl>
    implements _$$PincodeImplCopyWith<$Res> {
  __$$PincodeImplCopyWithImpl(
      _$PincodeImpl _value, $Res Function(_$PincodeImpl) _then)
      : super(_value, _then);

  /// Create a copy of Pincode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? status = freezed,
    Object? postOffice = freezed,
  }) {
    return _then(_$PincodeImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      postOffice: freezed == postOffice
          ? _value._postOffice
          : postOffice // ignore: cast_nullable_to_non_nullable
              as List<PostOffice>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PincodeImpl implements _Pincode {
  const _$PincodeImpl(
      {@JsonKey(name: "Message") this.message,
      @JsonKey(name: "Status") this.status,
      @JsonKey(name: "PostOffice") final List<PostOffice>? postOffice})
      : _postOffice = postOffice;

  factory _$PincodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$PincodeImplFromJson(json);

  @override
  @JsonKey(name: "Message")
  final String? message;
  @override
  @JsonKey(name: "Status")
  final String? status;
  final List<PostOffice>? _postOffice;
  @override
  @JsonKey(name: "PostOffice")
  List<PostOffice>? get postOffice {
    final value = _postOffice;
    if (value == null) return null;
    if (_postOffice is EqualUnmodifiableListView) return _postOffice;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Pincode(message: $message, status: $status, postOffice: $postOffice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PincodeImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._postOffice, _postOffice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, status,
      const DeepCollectionEquality().hash(_postOffice));

  /// Create a copy of Pincode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PincodeImplCopyWith<_$PincodeImpl> get copyWith =>
      __$$PincodeImplCopyWithImpl<_$PincodeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PincodeImplToJson(
      this,
    );
  }
}

abstract class _Pincode implements Pincode {
  const factory _Pincode(
          {@JsonKey(name: "Message") final String? message,
          @JsonKey(name: "Status") final String? status,
          @JsonKey(name: "PostOffice") final List<PostOffice>? postOffice}) =
      _$PincodeImpl;

  factory _Pincode.fromJson(Map<String, dynamic> json) = _$PincodeImpl.fromJson;

  @override
  @JsonKey(name: "Message")
  String? get message;
  @override
  @JsonKey(name: "Status")
  String? get status;
  @override
  @JsonKey(name: "PostOffice")
  List<PostOffice>? get postOffice;

  /// Create a copy of Pincode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PincodeImplCopyWith<_$PincodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PostOffice _$PostOfficeFromJson(Map<String, dynamic> json) {
  return _PostOffice.fromJson(json);
}

/// @nodoc
mixin _$PostOffice {
  @JsonKey(name: "Name")
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: "Description")
  dynamic get description => throw _privateConstructorUsedError;
  @JsonKey(name: "BranchType")
  String? get branchType => throw _privateConstructorUsedError;
  @JsonKey(name: "DeliveryStatus")
  String? get deliveryStatus => throw _privateConstructorUsedError;
  @JsonKey(name: "Circle")
  String? get circle => throw _privateConstructorUsedError;
  @JsonKey(name: "District")
  String? get district => throw _privateConstructorUsedError;
  @JsonKey(name: "Division")
  String? get division => throw _privateConstructorUsedError;
  @JsonKey(name: "Region")
  String? get region => throw _privateConstructorUsedError;
  @JsonKey(name: "Block")
  String? get block => throw _privateConstructorUsedError;
  @JsonKey(name: "State")
  String? get state => throw _privateConstructorUsedError;
  @JsonKey(name: "Country")
  String? get country => throw _privateConstructorUsedError;
  @JsonKey(name: "Pincode")
  String? get pincode => throw _privateConstructorUsedError;

  /// Serializes this PostOffice to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PostOffice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostOfficeCopyWith<PostOffice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostOfficeCopyWith<$Res> {
  factory $PostOfficeCopyWith(
          PostOffice value, $Res Function(PostOffice) then) =
      _$PostOfficeCopyWithImpl<$Res, PostOffice>;
  @useResult
  $Res call(
      {@JsonKey(name: "Name") String? name,
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
      @JsonKey(name: "Pincode") String? pincode});
}

/// @nodoc
class _$PostOfficeCopyWithImpl<$Res, $Val extends PostOffice>
    implements $PostOfficeCopyWith<$Res> {
  _$PostOfficeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostOffice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? branchType = freezed,
    Object? deliveryStatus = freezed,
    Object? circle = freezed,
    Object? district = freezed,
    Object? division = freezed,
    Object? region = freezed,
    Object? block = freezed,
    Object? state = freezed,
    Object? country = freezed,
    Object? pincode = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as dynamic,
      branchType: freezed == branchType
          ? _value.branchType
          : branchType // ignore: cast_nullable_to_non_nullable
              as String?,
      deliveryStatus: freezed == deliveryStatus
          ? _value.deliveryStatus
          : deliveryStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      circle: freezed == circle
          ? _value.circle
          : circle // ignore: cast_nullable_to_non_nullable
              as String?,
      district: freezed == district
          ? _value.district
          : district // ignore: cast_nullable_to_non_nullable
              as String?,
      division: freezed == division
          ? _value.division
          : division // ignore: cast_nullable_to_non_nullable
              as String?,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      block: freezed == block
          ? _value.block
          : block // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      pincode: freezed == pincode
          ? _value.pincode
          : pincode // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostOfficeImplCopyWith<$Res>
    implements $PostOfficeCopyWith<$Res> {
  factory _$$PostOfficeImplCopyWith(
          _$PostOfficeImpl value, $Res Function(_$PostOfficeImpl) then) =
      __$$PostOfficeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "Name") String? name,
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
      @JsonKey(name: "Pincode") String? pincode});
}

/// @nodoc
class __$$PostOfficeImplCopyWithImpl<$Res>
    extends _$PostOfficeCopyWithImpl<$Res, _$PostOfficeImpl>
    implements _$$PostOfficeImplCopyWith<$Res> {
  __$$PostOfficeImplCopyWithImpl(
      _$PostOfficeImpl _value, $Res Function(_$PostOfficeImpl) _then)
      : super(_value, _then);

  /// Create a copy of PostOffice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? branchType = freezed,
    Object? deliveryStatus = freezed,
    Object? circle = freezed,
    Object? district = freezed,
    Object? division = freezed,
    Object? region = freezed,
    Object? block = freezed,
    Object? state = freezed,
    Object? country = freezed,
    Object? pincode = freezed,
  }) {
    return _then(_$PostOfficeImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as dynamic,
      branchType: freezed == branchType
          ? _value.branchType
          : branchType // ignore: cast_nullable_to_non_nullable
              as String?,
      deliveryStatus: freezed == deliveryStatus
          ? _value.deliveryStatus
          : deliveryStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      circle: freezed == circle
          ? _value.circle
          : circle // ignore: cast_nullable_to_non_nullable
              as String?,
      district: freezed == district
          ? _value.district
          : district // ignore: cast_nullable_to_non_nullable
              as String?,
      division: freezed == division
          ? _value.division
          : division // ignore: cast_nullable_to_non_nullable
              as String?,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      block: freezed == block
          ? _value.block
          : block // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      pincode: freezed == pincode
          ? _value.pincode
          : pincode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostOfficeImpl implements _PostOffice {
  const _$PostOfficeImpl(
      {@JsonKey(name: "Name") this.name,
      @JsonKey(name: "Description") this.description,
      @JsonKey(name: "BranchType") this.branchType,
      @JsonKey(name: "DeliveryStatus") this.deliveryStatus,
      @JsonKey(name: "Circle") this.circle,
      @JsonKey(name: "District") this.district,
      @JsonKey(name: "Division") this.division,
      @JsonKey(name: "Region") this.region,
      @JsonKey(name: "Block") this.block,
      @JsonKey(name: "State") this.state,
      @JsonKey(name: "Country") this.country,
      @JsonKey(name: "Pincode") this.pincode});

  factory _$PostOfficeImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostOfficeImplFromJson(json);

  @override
  @JsonKey(name: "Name")
  final String? name;
  @override
  @JsonKey(name: "Description")
  final dynamic description;
  @override
  @JsonKey(name: "BranchType")
  final String? branchType;
  @override
  @JsonKey(name: "DeliveryStatus")
  final String? deliveryStatus;
  @override
  @JsonKey(name: "Circle")
  final String? circle;
  @override
  @JsonKey(name: "District")
  final String? district;
  @override
  @JsonKey(name: "Division")
  final String? division;
  @override
  @JsonKey(name: "Region")
  final String? region;
  @override
  @JsonKey(name: "Block")
  final String? block;
  @override
  @JsonKey(name: "State")
  final String? state;
  @override
  @JsonKey(name: "Country")
  final String? country;
  @override
  @JsonKey(name: "Pincode")
  final String? pincode;

  @override
  String toString() {
    return 'PostOffice(name: $name, description: $description, branchType: $branchType, deliveryStatus: $deliveryStatus, circle: $circle, district: $district, division: $division, region: $region, block: $block, state: $state, country: $country, pincode: $pincode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostOfficeImpl &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            (identical(other.branchType, branchType) ||
                other.branchType == branchType) &&
            (identical(other.deliveryStatus, deliveryStatus) ||
                other.deliveryStatus == deliveryStatus) &&
            (identical(other.circle, circle) || other.circle == circle) &&
            (identical(other.district, district) ||
                other.district == district) &&
            (identical(other.division, division) ||
                other.division == division) &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.block, block) || other.block == block) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.pincode, pincode) || other.pincode == pincode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      const DeepCollectionEquality().hash(description),
      branchType,
      deliveryStatus,
      circle,
      district,
      division,
      region,
      block,
      state,
      country,
      pincode);

  /// Create a copy of PostOffice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostOfficeImplCopyWith<_$PostOfficeImpl> get copyWith =>
      __$$PostOfficeImplCopyWithImpl<_$PostOfficeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostOfficeImplToJson(
      this,
    );
  }
}

abstract class _PostOffice implements PostOffice {
  const factory _PostOffice(
      {@JsonKey(name: "Name") final String? name,
      @JsonKey(name: "Description") final dynamic description,
      @JsonKey(name: "BranchType") final String? branchType,
      @JsonKey(name: "DeliveryStatus") final String? deliveryStatus,
      @JsonKey(name: "Circle") final String? circle,
      @JsonKey(name: "District") final String? district,
      @JsonKey(name: "Division") final String? division,
      @JsonKey(name: "Region") final String? region,
      @JsonKey(name: "Block") final String? block,
      @JsonKey(name: "State") final String? state,
      @JsonKey(name: "Country") final String? country,
      @JsonKey(name: "Pincode") final String? pincode}) = _$PostOfficeImpl;

  factory _PostOffice.fromJson(Map<String, dynamic> json) =
      _$PostOfficeImpl.fromJson;

  @override
  @JsonKey(name: "Name")
  String? get name;
  @override
  @JsonKey(name: "Description")
  dynamic get description;
  @override
  @JsonKey(name: "BranchType")
  String? get branchType;
  @override
  @JsonKey(name: "DeliveryStatus")
  String? get deliveryStatus;
  @override
  @JsonKey(name: "Circle")
  String? get circle;
  @override
  @JsonKey(name: "District")
  String? get district;
  @override
  @JsonKey(name: "Division")
  String? get division;
  @override
  @JsonKey(name: "Region")
  String? get region;
  @override
  @JsonKey(name: "Block")
  String? get block;
  @override
  @JsonKey(name: "State")
  String? get state;
  @override
  @JsonKey(name: "Country")
  String? get country;
  @override
  @JsonKey(name: "Pincode")
  String? get pincode;

  /// Create a copy of PostOffice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostOfficeImplCopyWith<_$PostOfficeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
