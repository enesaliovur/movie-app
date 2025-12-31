import 'package:boby_ai_case/core/config/app_config.dart';
import 'package:boby_ai_case/core/network/interceptors/http_interceptor.dart';
import 'package:boby_ai_case/setup_environment.dart';
import 'package:dio/dio.dart';

class Client {
  static final Client _instance = Client._();
  late final Dio _dioInstance;

  factory Client() => _instance;

  Client._() {
    _dioInstance = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Environment.apiKey}',
        },
        responseType: ResponseType.json,
      ),
    );

    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dioInstance.interceptors.add(HttpInterceptor());
  }

  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dioInstance.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<dynamic>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dioInstance.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Dio get dio => _dioInstance;
}
