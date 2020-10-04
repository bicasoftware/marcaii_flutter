import 'dart:io';

import 'package:dio/dio.dart';
import 'package:marcaii_flutter/src/connection/connection_retry.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  RetryOnConnectionChangeInterceptor({this.retrier});
  final DioConnectionRetry retrier;

  @override
  Future onError(DioError err) async {
    if (_shouldRetry(err)) {
      try {
        return retrier.scheduleRetry(err.request);
      } catch (e) {
        return e;
      }
    }
    return err;
  }

  bool _shouldRetry(DioError e) {
    return e.type == DioErrorType.DEFAULT && e.error != null && e is SocketException;
  }
}
