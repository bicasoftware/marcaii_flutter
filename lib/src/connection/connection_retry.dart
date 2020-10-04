import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioConnectionRetry {
  DioConnectionRetry({
    @required this.dio,
    @required this.connectivity,
  });

  final Dio dio;
  final Connectivity connectivity;

  Future<Response> scheduleRetry(RequestOptions reqOptions) async {
    StreamSubscription subscription;
    final completer = Completer<Response>();

    subscription = connectivity.onConnectivityChanged.listen(
      (ConnectivityResult connResult) {
        if (connResult != ConnectivityResult.none) {
          subscription.cancel();
          completer.complete(
            dio.request<Object>(
              reqOptions.path,
              cancelToken: reqOptions.cancelToken,
              data: reqOptions.data,
              onReceiveProgress: reqOptions.onReceiveProgress,
              onSendProgress: reqOptions.onSendProgress,
              queryParameters: reqOptions.queryParameters,
              options: reqOptions,
            ),
          );
        }
      },
    );

    return completer.future;
  }
}
