import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_user_request.freezed.dart';
part 'update_user_request.g.dart';

@freezed
class UpdateUserRequest with _$UpdateUserRequest {
  factory UpdateUserRequest({
    String? phoneNumber,
    List<String>? roleIds,
    required String displayName,
    required String email,
  }) = _UpdateUserRequest;

  factory UpdateUserRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserRequestFromJson(json);
}
