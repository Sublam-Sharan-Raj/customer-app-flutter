// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Address _$AddressFromJson(Map<String, dynamic> json) {
  return _Address.fromJson(json);
}

/// @nodoc
mixin _$Address {
  @JsonKey(name: "id")
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "type")
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: "line")
  String? get line => throw _privateConstructorUsedError;
  @JsonKey(name: "landmark")
  String? get landmark => throw _privateConstructorUsedError;
  @JsonKey(name: "pincode")
  int? get pincode => throw _privateConstructorUsedError;
  @JsonKey(name: "geo_coordinates")
  GeoCoordinates? get geoCoordinates => throw _privateConstructorUsedError;

  /// Serializes this Address to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddressCopyWith<Address> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressCopyWith<$Res> {
  factory $AddressCopyWith(Address value, $Res Function(Address) then) =
      _$AddressCopyWithImpl<$Res, Address>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") String? id,
      @JsonKey(name: "type") String? type,
      @JsonKey(name: "line") String? line,
      @JsonKey(name: "landmark") String? landmark,
      @JsonKey(name: "pincode") int? pincode,
      @JsonKey(name: "geo_coordinates") GeoCoordinates? geoCoordinates});

  $GeoCoordinatesCopyWith<$Res>? get geoCoordinates;
}

/// @nodoc
class _$AddressCopyWithImpl<$Res, $Val extends Address>
    implements $AddressCopyWith<$Res> {
  _$AddressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? line = freezed,
    Object? landmark = freezed,
    Object? pincode = freezed,
    Object? geoCoordinates = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      line: freezed == line
          ? _value.line
          : line // ignore: cast_nullable_to_non_nullable
              as String?,
      landmark: freezed == landmark
          ? _value.landmark
          : landmark // ignore: cast_nullable_to_non_nullable
              as String?,
      pincode: freezed == pincode
          ? _value.pincode
          : pincode // ignore: cast_nullable_to_non_nullable
              as int?,
      geoCoordinates: freezed == geoCoordinates
          ? _value.geoCoordinates
          : geoCoordinates // ignore: cast_nullable_to_non_nullable
              as GeoCoordinates?,
    ) as $Val);
  }

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GeoCoordinatesCopyWith<$Res>? get geoCoordinates {
    if (_value.geoCoordinates == null) {
      return null;
    }

    return $GeoCoordinatesCopyWith<$Res>(_value.geoCoordinates!, (value) {
      return _then(_value.copyWith(geoCoordinates: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AddressImplCopyWith<$Res> implements $AddressCopyWith<$Res> {
  factory _$$AddressImplCopyWith(
          _$AddressImpl value, $Res Function(_$AddressImpl) then) =
      __$$AddressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") String? id,
      @JsonKey(name: "type") String? type,
      @JsonKey(name: "line") String? line,
      @JsonKey(name: "landmark") String? landmark,
      @JsonKey(name: "pincode") int? pincode,
      @JsonKey(name: "geo_coordinates") GeoCoordinates? geoCoordinates});

  @override
  $GeoCoordinatesCopyWith<$Res>? get geoCoordinates;
}

/// @nodoc
class __$$AddressImplCopyWithImpl<$Res>
    extends _$AddressCopyWithImpl<$Res, _$AddressImpl>
    implements _$$AddressImplCopyWith<$Res> {
  __$$AddressImplCopyWithImpl(
      _$AddressImpl _value, $Res Function(_$AddressImpl) _then)
      : super(_value, _then);

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? line = freezed,
    Object? landmark = freezed,
    Object? pincode = freezed,
    Object? geoCoordinates = freezed,
  }) {
    return _then(_$AddressImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      line: freezed == line
          ? _value.line
          : line // ignore: cast_nullable_to_non_nullable
              as String?,
      landmark: freezed == landmark
          ? _value.landmark
          : landmark // ignore: cast_nullable_to_non_nullable
              as String?,
      pincode: freezed == pincode
          ? _value.pincode
          : pincode // ignore: cast_nullable_to_non_nullable
              as int?,
      geoCoordinates: freezed == geoCoordinates
          ? _value.geoCoordinates
          : geoCoordinates // ignore: cast_nullable_to_non_nullable
              as GeoCoordinates?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddressImpl implements _Address {
  const _$AddressImpl(
      {@JsonKey(name: "id") this.id,
      @JsonKey(name: "type") this.type,
      @JsonKey(name: "line") this.line,
      @JsonKey(name: "landmark") this.landmark,
      @JsonKey(name: "pincode") this.pincode,
      @JsonKey(name: "geo_coordinates") this.geoCoordinates});

  factory _$AddressImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddressImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final String? id;
  @override
  @JsonKey(name: "type")
  final String? type;
  @override
  @JsonKey(name: "line")
  final String? line;
  @override
  @JsonKey(name: "landmark")
  final String? landmark;
  @override
  @JsonKey(name: "pincode")
  final int? pincode;
  @override
  @JsonKey(name: "geo_coordinates")
  final GeoCoordinates? geoCoordinates;

  @override
  String toString() {
    return 'Address(id: $id, type: $type, line: $line, landmark: $landmark, pincode: $pincode, geoCoordinates: $geoCoordinates)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.landmark, landmark) ||
                other.landmark == landmark) &&
            (identical(other.pincode, pincode) || other.pincode == pincode) &&
            (identical(other.geoCoordinates, geoCoordinates) ||
                other.geoCoordinates == geoCoordinates));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, type, line, landmark, pincode, geoCoordinates);

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressImplCopyWith<_$AddressImpl> get copyWith =>
      __$$AddressImplCopyWithImpl<_$AddressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddressImplToJson(
      this,
    );
  }
}

abstract class _Address implements Address {
  const factory _Address(
      {@JsonKey(name: "id") final String? id,
      @JsonKey(name: "type") final String? type,
      @JsonKey(name: "line") final String? line,
      @JsonKey(name: "landmark") final String? landmark,
      @JsonKey(name: "pincode") final int? pincode,
      @JsonKey(name: "geo_coordinates")
      final GeoCoordinates? geoCoordinates}) = _$AddressImpl;

  factory _Address.fromJson(Map<String, dynamic> json) = _$AddressImpl.fromJson;

  @override
  @JsonKey(name: "id")
  String? get id;
  @override
  @JsonKey(name: "type")
  String? get type;
  @override
  @JsonKey(name: "line")
  String? get line;
  @override
  @JsonKey(name: "landmark")
  String? get landmark;
  @override
  @JsonKey(name: "pincode")
  int? get pincode;
  @override
  @JsonKey(name: "geo_coordinates")
  GeoCoordinates? get geoCoordinates;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddressImplCopyWith<_$AddressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GeoCoordinates _$GeoCoordinatesFromJson(Map<String, dynamic> json) {
  return _GeoCoordinates.fromJson(json);
}

/// @nodoc
mixin _$GeoCoordinates {
  @JsonKey(name: "latitude")
  double? get latitude => throw _privateConstructorUsedError;
  @JsonKey(name: "longitude")
  double? get longitude => throw _privateConstructorUsedError;

  /// Serializes this GeoCoordinates to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GeoCoordinates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GeoCoordinatesCopyWith<GeoCoordinates> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeoCoordinatesCopyWith<$Res> {
  factory $GeoCoordinatesCopyWith(
          GeoCoordinates value, $Res Function(GeoCoordinates) then) =
      _$GeoCoordinatesCopyWithImpl<$Res, GeoCoordinates>;
  @useResult
  $Res call(
      {@JsonKey(name: "latitude") double? latitude,
      @JsonKey(name: "longitude") double? longitude});
}

/// @nodoc
class _$GeoCoordinatesCopyWithImpl<$Res, $Val extends GeoCoordinates>
    implements $GeoCoordinatesCopyWith<$Res> {
  _$GeoCoordinatesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GeoCoordinates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(_value.copyWith(
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GeoCoordinatesImplCopyWith<$Res>
    implements $GeoCoordinatesCopyWith<$Res> {
  factory _$$GeoCoordinatesImplCopyWith(_$GeoCoordinatesImpl value,
          $Res Function(_$GeoCoordinatesImpl) then) =
      __$$GeoCoordinatesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "latitude") double? latitude,
      @JsonKey(name: "longitude") double? longitude});
}

/// @nodoc
class __$$GeoCoordinatesImplCopyWithImpl<$Res>
    extends _$GeoCoordinatesCopyWithImpl<$Res, _$GeoCoordinatesImpl>
    implements _$$GeoCoordinatesImplCopyWith<$Res> {
  __$$GeoCoordinatesImplCopyWithImpl(
      _$GeoCoordinatesImpl _value, $Res Function(_$GeoCoordinatesImpl) _then)
      : super(_value, _then);

  /// Create a copy of GeoCoordinates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(_$GeoCoordinatesImpl(
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GeoCoordinatesImpl implements _GeoCoordinates {
  const _$GeoCoordinatesImpl(
      {@JsonKey(name: "latitude") this.latitude,
      @JsonKey(name: "longitude") this.longitude});

  factory _$GeoCoordinatesImpl.fromJson(Map<String, dynamic> json) =>
      _$$GeoCoordinatesImplFromJson(json);

  @override
  @JsonKey(name: "latitude")
  final double? latitude;
  @override
  @JsonKey(name: "longitude")
  final double? longitude;

  @override
  String toString() {
    return 'GeoCoordinates(latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeoCoordinatesImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, latitude, longitude);

  /// Create a copy of GeoCoordinates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GeoCoordinatesImplCopyWith<_$GeoCoordinatesImpl> get copyWith =>
      __$$GeoCoordinatesImplCopyWithImpl<_$GeoCoordinatesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GeoCoordinatesImplToJson(
      this,
    );
  }
}

abstract class _GeoCoordinates implements GeoCoordinates {
  const factory _GeoCoordinates(
          {@JsonKey(name: "latitude") final double? latitude,
          @JsonKey(name: "longitude") final double? longitude}) =
      _$GeoCoordinatesImpl;

  factory _GeoCoordinates.fromJson(Map<String, dynamic> json) =
      _$GeoCoordinatesImpl.fromJson;

  @override
  @JsonKey(name: "latitude")
  double? get latitude;
  @override
  @JsonKey(name: "longitude")
  double? get longitude;

  /// Create a copy of GeoCoordinates
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GeoCoordinatesImplCopyWith<_$GeoCoordinatesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
