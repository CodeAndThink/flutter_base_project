import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_base_project/core/configs/app_configs.dart';
import 'api_constants.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: AppConfigs.connectTimeout,
        sendTimeout: AppConfigs.sendTimeout,
        receiveTimeout: AppConfigs.receiveTimeout,
        queryParameters: {'api_key': ApiConstants.apiToken},
      ),
    );

    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(responseBody: true, requestBody: true),
      );
    }
  }

  Dio get dio => _dio;
}
