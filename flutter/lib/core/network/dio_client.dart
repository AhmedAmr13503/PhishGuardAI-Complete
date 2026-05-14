import 'dart:developer' as developer;

import 'package:dio/dio.dart';

import '../constants/api_constants.dart';

class _LoggingInterceptor extends Interceptor {
  void _log(String message) {
    developer.log(message, name: 'Dio');
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _log('request URL: ${options.uri}');
    _log('request method: ${options.method}');
    _log('request headers: ${options.headers}');
    if (options.data != null) {
      _log('request body: ${options.data}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _log('response status: ${response.statusCode}');
    _log('response URL: ${response.requestOptions.uri}');
    _log('response body: ${response.data}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _log('request URL (failed): ${err.requestOptions.uri}');
    _log('request headers: ${err.requestOptions.headers}');
    if (err.requestOptions.data != null) {
      _log('request body: ${err.requestOptions.data}');
    }
    _log('error type: ${err.type}');
    _log('error message: ${err.message}');
    if (err.response != null) {
      _log('response status: ${err.response?.statusCode}');
      _log('response body: ${err.response?.data}');
    }
    handler.next(err);
  }
}

/// Shared HTTP client with JSON defaults, timeouts, and request/response logging.
class DioClient {
  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: const <String, dynamic>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // Helps some ngrok-free tunnels accept programmatic clients.
          'ngrok-skip-browser-warning': 'true',
        },
        responseType: ResponseType.json,
        followRedirects: true,
        validateStatus: (status) =>
            status != null && status >= 200 && status < 600,
        receiveDataWhenStatusError: true,
      ),
    );
    _dio.interceptors.add(_LoggingInterceptor());
  }

  late final Dio _dio;

  Dio get dio => _dio;
}
