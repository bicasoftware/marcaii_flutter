import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marcaii_flutter/src/server/clients/user_client.dart';
import 'package:marcaii_flutter/src/server/connector.dart';
import 'package:marcaii_flutter/src/server/models/error_dto.dart';
import 'package:marcaii_flutter/src/server/models/user_data_dto.dart';
import 'package:marcaii_flutter/src/server/models/user_dto.dart';
import 'package:marcaii_flutter/src/utils/helpers/nullable_helper.dart';

void main() {
  final user = UserDto(email: "saulo@test.com", password: "S17h05a8", username: "sauloandrioli");
  final dio = Connector.connect();
  final cliente = UserClient(dio);

  test('auth test', () async {
    try {
      final UserDataDto authData = await cliente.authenticate(user);
      assert(authData.email.isNotNull);
      assert(authData.email.isNotEmpty);
      assert(authData.token.isNotNull);
      assert(authData.token.isNotEmpty);
      assert(authData.empregos.isNotEmpty);
      print(authData.empregos.length ?? 99999);
    } catch (e) {
      if (e is DioError) {
        final error = ErroDto.fromJson(e.response.data[0]);
        print(error.field);
        print(error.message);
        // final error = ErroDto.fromJson(e.response.data);
        // print("Error: ${error.field}, ${e.message}");
      } else {
        print(e);
      }
    }
  });

  // test('authentication routine', () async {
  //   try {
  //     final registerData = await cliente.register(user);
  //     assert(registerData.email.isNotNull);
  //     assert(registerData.token.isNotEmpty);

  //     final UserDataDto authData = await cliente.authenticate(user);
  //     assert(authData.email.isNotNull);
  //     assert(authData.email.isNotEmpty);
  //     assert(authData.token.isNotNull);
  //     assert(authData.token.isNotEmpty);

  //     final refreshToken = await cliente.refreshToken(
  //       RefreshTokenDto(refresh_token: authData.refresh_token),
  //     );

  //     assert(refreshToken.token.isNotNull && refreshToken.token.isNotEmpty);
  //     assert(refreshToken.token != authData.token);

  //     final dio = Dio();
  //     dio.options.headers['Authorization'] = "Bearer ${authData.token}";
  //     final unregisterClient = UserClient(dio);

  //     final unregisterDto = await unregisterClient.unregister();
  //     assert(unregisterDto.removed == true);
  //   } catch (e) {
  //     if (e is DioError) {
  //       print(e.response.data);
  //     }
  //   }
  // });
}
