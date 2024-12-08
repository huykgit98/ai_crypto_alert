import 'package:ai_crypto_alert/core/client/remote/auth_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final dioProvider = Provider((ref) {
  final dio = Dio();

  dio.interceptors.add(ref.read(authInterceptorProvider));
  if (!kReleaseMode) {
    // dio.interceptors.add(ref.read(loggerInterceptorProvider));
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        filter: (options, args) {
          //  return !options.uri.path.contains('posts');
          return !args.isResponse || !args.hasUint8ListData;
        },
      ),
    );
  }
  return dio;
});
