// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_user_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UpdateUserRequest _$UpdateUserRequestFromJson(Map<String, dynamic> json) {
  return _UpdateUserRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateUserRequest {
  String? get phoneNumber => throw _privateConstructorUsedError;
  List<String>? get roleIds => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;

  /// Serializes this UpdateUserRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateUserRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateUserRequestCopyWith<UpdateUserRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateUserRequestCopyWith<$Res> {
  factory $UpdateUserRequestCopyWith(
          UpdateUserRequest value, $Res Function(UpdateUserRequest) then) =
      _$UpdateUserRequestCopyWithImpl<$Res, UpdateUserRequest>;
  @useResult
  $Res call(
      {String? phoneNumber,
      List<String>? roleIds,
      String displayName,
      String email});
}

/// @nodoc
class _$UpdateUserRequestCopyWithImpl<$Res, $Val extends UpdateUserRequest>
    implements $UpdateUserRequestCopyWith<$Res> {
  _$UpdateUserRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateUserRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = freezed,
    Object? roleIds = freezed,
    Object? displayName = null,
    Object? email = null,
  }) {
    return _then(_value.copyWith(
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      roleIds: freezed == roleIds
          ? _value.roleIds
          : roleIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateUserRequestImplCopyWith<$Res>
    implements $UpdateUserRequestCopyWith<$Res> {
  factory _$$UpdateUserRequestImplCopyWith(_$UpdateUserRequestImpl value,
          $Res Function(_$UpdateUserRequestImpl) then) =
      __$$UpdateUserRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? phoneNumber,
      List<String>? roleIds,
      String displayName,
      String email});
}

/// @nodoc
class __$$UpdateUserRequestImplCopyWithImpl<$Res>
    extends _$UpdateUserRequestCopyWithImpl<$Res, _$UpdateUserRequestImpl>
    implements _$$UpdateUserRequestImplCopyWith<$Res> {
  __$$UpdateUserRequestImplCopyWithImpl(_$UpdateUserRequestImpl _value,
      $Res Function(_$UpdateUserRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateUserRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = freezed,
    Object? roleIds = freezed,
    Object? displayName = null,
    Object? email = null,
  }) {
    return _then(_$UpdateUserRequestImpl(
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      roleIds: freezed == roleIds
          ? _value._roleIds
          : roleIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateUserRequestImpl implements _UpdateUserRequest {
  _$UpdateUserRequestImpl(
      {this.phoneNumber,
      final List<String>? roleIds,
      required this.displayName,
      required this.email})
      : _roleIds = roleIds;

  factory _$UpdateUserRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateUserRequestImplFromJson(json);

  @override
  final String? phoneNumber;
  final List<String>? _roleIds;
  @override
  List<String>? get roleIds {
    final value = _roleIds;
    if (value == null) return null;
    if (_roleIds is EqualUnmodifiableListView) return _roleIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String displayName;
  @override
  final String email;

  @override
  String toString() {
    return 'UpdateUserRequest(phoneNumber: $phoneNumber, roleIds: $roleIds, displayName: $displayName, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateUserRequestImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            const DeepCollectionEquality().equals(other._roleIds, _roleIds) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, phoneNumber,
      const DeepCollectionEquality().hash(_roleIds), displayName, email);

  /// Create a copy of UpdateUserRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateUserRequestImplCopyWith<_$UpdateUserRequestImpl> get copyWith =>
      __$$UpdateUserRequestImplCopyWithImpl<_$UpdateUserRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateUserRequestImplToJson(
      this,
    );
  }
}

abstract class _UpdateUserRequest implements UpdateUserRequest {
  factory _UpdateUserRequest(
      {final String? phoneNumber,
      final List<String>? roleIds,
      required final String displayName,
      required final String email}) = _$UpdateUserRequestImpl;

  factory _UpdateUserRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateUserRequestImpl.fromJson;

  @override
  String? get phoneNumber;
  @override
  List<String>? get roleIds;
  @override
  String get displayName;
  @override
  String get email;

  /// Create a copy of UpdateUserRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateUserRequestImplCopyWith<_$UpdateUserRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
