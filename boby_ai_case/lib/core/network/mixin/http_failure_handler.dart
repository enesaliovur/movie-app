import 'dart:io';

import 'package:boby_ai_case/core/failure/failure.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

mixin HttpFailureHandlerMixin {
  HttpFailureHandler get httpFailureHandler;

  Failure? handleResult(int statusCode, Map<String, dynamic> result) {
    return httpFailureHandler.handleResult(statusCode, result);
  }

  Failure handleErrorsAndExceptions(Object e) {
    return httpFailureHandler.handleErrorsAndExceptions(e);
  }
}

class HttpFailureHandler {
  const HttpFailureHandler();

  @visibleForTesting
  Failure? handleResult(int statusCode, Map<String, dynamic> result) {
    if (statusCode.toString().startsWith('2')) return null;

    if (statusCode == 400) {
      return const BadRequestFailure();
    } else if (statusCode == 403) {
      return const ForbiddenFailure();
    } else if (statusCode == 404) {
      return const NotFoundFailure();
    } else if (statusCode == 500) {
      return const ServerFailure();
    } else {
      return const UnknownFailure();
    }
  }

  @visibleForTesting
  Failure handleErrorsAndExceptions(Object e) {
    if (e is SocketException) {
      return const ConnectionFailure();
    } else if (e is DioException) {
      final statusCode = e.response?.statusCode;
      if (statusCode != null) {
        return handleResult(statusCode, {}) ?? const UnknownFailure();
      }
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return const ConnectionFailure();
      }
      return const UnknownFailure();
    } else {
      return const UnknownFailure();
    }
  }
}
