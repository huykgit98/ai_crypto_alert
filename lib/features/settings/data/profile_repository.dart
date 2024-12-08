import 'package:ai_crypto_alert/core/client/remote/dio_provider.dart';
import 'package:ai_crypto_alert/core/client/remote/http_helper.dart';
import 'package:ai_crypto_alert/features/settings/domain/models.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_repository.g.dart';

class ProfileRepository {
  ProfileRepository(this._client);

  final Dio _client;

  Future<Profile?> getUserProfile(CancelToken? cancelToken) async {
    try {
      final response = await HttpClientHelper.get<Map<String, dynamic>>(
        client: _client,
        path: 'api/user/me',
        cancelToken: cancelToken,
      );

      // Check if response data is non-null and correctly formatted
      if (response.statusCode == 200 && response.data != null) {
        // Safely parse the data
        return Profile.fromJson(response.data ?? {});
      } else {
        if (kDebugMode) {
          print('Unexpected response format: ${response.data}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user profile: $e');
      }
    }
    return null; // Explicitly return null if the profile fetch fails
  }

  Future<Profile?> updateUser({
    required String userId,
    required UpdateUserRequest request,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await HttpClientHelper.put<Map<String, dynamic>>(
        client: _client,
        path: 'api/user/$userId',
        data: request.toJson(),
        cancelToken: cancelToken,
      );

      if (response.statusCode == 200 && response.data != null) {
        return Profile.fromJson(response.data!);
      } else {
        if (kDebugMode) {
          print('Unexpected response format: ${response.data}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating user: $e');
      }
    }
    return null; // Explicitly return null if the update fails
  }
}

@Riverpod(keepAlive: true)
ProfileRepository profileRepository(Ref ref) =>
    ProfileRepository(ref.watch(dioProvider));

@riverpod
Future<Profile?> profileFuture(Ref ref) {
  final profileRepository = ref.watch(profileRepositoryProvider);
  final cancelToken = CancelToken();

  return profileRepository.getUserProfile(cancelToken);
}
