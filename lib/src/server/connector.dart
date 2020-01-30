import 'package:dio/dio.dart';

class Connector {
  static const token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjEsImlhdCI6MTU4MDMzODQwNn0.CrnHdMd53rzoSEm1-GmjT7My1AoyMtS018Si7AFJFkI";

  static const refreshToken =
      "8e27eb7fd87449b9ff25812ecda257f9Xz9TEfCY6ITiffRgeTX2io1+v+P/vOr5iG/nbcWlwHkQwwyzlNbCTSzecs8AoZj0";

  static Dio connect() => Dio()..options.headers['Authentication'] = token;
}
