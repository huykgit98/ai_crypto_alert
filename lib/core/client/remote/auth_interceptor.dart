import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authInterceptorProvider = Provider((ref) => AuthInterceptor());

class AuthInterceptor extends Interceptor {
  @override
  Future<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // final user = FirebaseAuth.instance.currentUser;
    // if (user != null) {
    //   final token = await user.getIdToken();
    //   if (kDebugMode) {
    //     print('Token: $token');
    //   }
    //   if (token != null && token.isNotEmpty) {
    //     options.headers['Authorization'] = 'Bearer $token';
    //   }
    // }
    return super.onRequest(options, handler);
  }

  @override
  Future<dynamic> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (kDebugMode) {
      print('Error[${err.response?.statusCode}]: ${err.response?.data}');
    }

    // Check for token expiration (401 status code)
    // if (err.response?.statusCode == 401) {
    //   try {
    //     // Attempt to refresh the token if possible
    //     final user = FirebaseAuth.instance.currentUser;
    //     if (user != null) {
    //       // Force a token refresh
    //       final newToken = await user.getIdToken(true);
    //       if (kDebugMode) {
    //         print('Refreshed Token: $newToken');
    //       }
    //
    //       // Retry the request with the new token
    //       if (newToken!.isNotEmpty) {
    //         final RequestOptions requestOptions = err.requestOptions;
    //         requestOptions.headers['Authorization'] = 'Bearer $newToken';
    //
    //         // Create a new Dio instance to retry the request
    //         final response =
    //             await Dio().fetch<Response<dynamic>>(requestOptions);
    //         return handler.resolve(response);
    //       }
    //     }
    //   } catch (e) {
    //     // Handle token refresh error (e.g., if user is logged out or network error)
    //     if (kDebugMode) {
    //       print('Error refreshing token: $e');
    //     }
    //   }
    // }

    // If error is not handled, continue with the error handler
    return super.onError(err, handler);
  }
}
