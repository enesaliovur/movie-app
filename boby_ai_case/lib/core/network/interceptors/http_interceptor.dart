import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class HttpInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('''
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
    debugPrint('''
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
    debugPrint('''
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
