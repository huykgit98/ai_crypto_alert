import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

typedef ProfileID = String;

@freezed
class Profile with _$Profile {
  factory Profile({
    required ProfileID id,
    required String? userName,
    required String? email,
    required String? displayName,
    required List<UserRole>? userRoles,
    String? phoneNumber,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}

@freezed
class UserRole with _$UserRole {
  factory UserRole({
    required String id,
    required String name,
  }) = _UserRole;

  factory UserRole.fromJson(Map<String, dynamic> json) =>
      _$UserRoleFromJson(json);
}
