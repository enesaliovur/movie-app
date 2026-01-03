import 'package:boby_ai_case/core/config/app_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class HttpInterceptor extends Interceptor {
  void _log(String message) {
    if (AppConfig.enableLogging) {
      debugPrint(message);
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _log('''
      ═══════════════════════════════════════════════════════════
      REQUEST
      ───────────────────────────────────────────────────────────
      Method: ${options.method}
      URL: ${options.baseUrl}${options.path}
      Headers: ${options.headers}
      Query Parameters: ${options.queryParameters}
      ═══════════════════════════════════════════════════════════
      ''');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _log('''
      ═══════════════════════════════════════════════════════════
      RESPONSE
      ───────────────────────────────────────────────────────────
      Status Code: ${response.statusCode}
      URL: ${response.requestOptions.baseUrl}${response.requestOptions.path}
      ═══════════════════════════════════════════════════════════
      ''');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _log('''
      ═══════════════════════════════════════════════════════════
      ERROR
      ───────────────────────────────────────────────────────────
      URL: ${err.requestOptions.baseUrl}${err.requestOptions.path}
      Status Code: ${err.response?.statusCode}
      Error Type: ${err.type}
      Message: ${err.message}
      ═══════════════════════════════════════════════════════════
      ''');
    handler.next(err);
  }
}
