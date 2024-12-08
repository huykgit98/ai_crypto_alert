// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpdateUserRequestImpl _$$UpdateUserRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateUserRequestImpl(
      phoneNumber: json['phoneNumber'] as String?,
      roleIds:
          (json['roleIds'] as List<dynamic>?)?.map((e) => e as String).toList(),
      displayName: json['displayName'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$$UpdateUserRequestImplToJson(
        _$UpdateUserRequestImpl instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'roleIds': instance.roleIds,
      'displayName': instance.displayName,
      'email': instance.email,
    };
