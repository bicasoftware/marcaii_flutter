import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:marcaii_flutter/src/connection/connection_retry.dart';
import 'package:marcaii_flutter/src/connection/retry_interceptor.dart';

Dio provideDio() {
  return DioProvider().dio;
}

class DioProvider {
  factory DioProvider() {
    return _instance;
  }

  DioProvider._();

  static final DioProvider _instance = DioProvider._();
  static Dio _dio;

  Dio get dio {
    return _dio ??= _init();
  }

  Dio _init() {
    final dio = Dio(BaseOptions(headers: <String, String>{
      "Accept": "application/json",
    }));

    dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        retrier: DioConnectionRetry(
          connectivity: Connectivity(),
          dio: dio,
        ),
      ),
    );
    //TODO - Add token info in options
    return dio;
  }
}
