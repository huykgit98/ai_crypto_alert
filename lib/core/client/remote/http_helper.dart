import 'package:ai_crypto_alert/core/config/app_config.dart';
import 'package:dio/dio.dart';

class HttpClientHelper {
  // Static method for POST requests, supporting both FormData and Map<String, dynamic>
  static Future<Response<T>> post<T>({
    required Dio client,
    required String path,
    dynamic data,
    CancelToken? cancelToken,
  }) async {
    final uri = _buildUri(path);
    return client.postUri<T>(
      uri,
      data: data,
      options: _defaultOptions(),
      cancelToken: cancelToken,
    );
  }

  // Static method for GET requests with optional query parameters
  static Future<Response<T>> get<T>({
    required Dio client,
    required String path,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    final uri = _buildUri(path, queryParameters: queryParameters);
    return client.getUri<T>(
      uri,
      options: _defaultOptions(),
      cancelToken: cancelToken,
    );
  }

  // Static method for PUT requests, supporting both FormData and Map<String, dynamic>
  static Future<Response<T>> put<T>({
    required Dio client,
    required String path,
    dynamic data,
    CancelToken? cancelToken,
  }) async {
    final uri = _buildUri(path);
    return client.putUri<T>(
      uri,
      data: data,
      options: _defaultOptions(),
      cancelToken: cancelToken,
    );
  }

  // Private method to build URI based on AppConfig, with optional query parameters
  static Uri _buildUri(String path, {Map<String, dynamic>? queryParameters}) {
    return Uri(
      scheme: AppConfig.scheme,
      host: AppConfig.baseUrl,
      port: AppConfig.port,
      path: path,
      queryParameters: queryParameters,
    );
  }

  // Private method to return default options for requests
  static Options _defaultOptions() {
    return Options(
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
      },
    );
  }
}
