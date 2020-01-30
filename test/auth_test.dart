import 'package:flutter_test/flutter_test.dart';
import 'package:marcaii_flutter/src/server/clients/user_client.dart';
import 'package:marcaii_flutter/src/server/connector.dart';
import 'package:marcaii_flutter/src/server/models/user_data_dto.dart';
import 'package:marcaii_flutter/src/server/models/user_dto.dart';

void main() {
  test('authenticate', () async {
    final dio = Connector.connect();
    final cliente = UserClient(dio);

    final UserDataDto result = await cliente.authenticate(
        UserDto(email: "saulo@test.com", password: "S17h05a8", username: "sauloandrioli"));

    print(result.email);
    print(result.token);
    result.empregos.forEach((e) {
      print(e.nome);
    });
  });
}
