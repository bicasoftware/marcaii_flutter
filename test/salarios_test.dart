import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marcaii_flutter/src/database/models/salarios.dart';
import 'package:marcaii_flutter/src/server/clients/salarios_client.dart';
import 'package:marcaii_flutter/src/server/clients/user_client.dart';
import 'package:marcaii_flutter/src/server/models/user_dto.dart';

void main() {
  test('test salario', () async {
    final dio = Dio();
    final authClient = UserClient(dio);
    final userData = await authClient.authenticate(
      UserDto(
        email: "saulo@test.com",
        password: "S17h05a8",
        username: "sauloandrioli",
      ),
    );

    dio.options.headers['Authorization'] = "Bearer ${userData.token}";
    final empregoId = userData.empregos.first.id;

    final clientSalarios = SalariosClient(dio);

    var salario = Salarios(
      emprego_id: empregoId,
      valor: 1364.66,
      vigencia: '01/2020',
    );

    salario = await clientSalarios.post(salario);
    assert(salario.id != null);

    final update = await clientSalarios.put(
      salario.id,
      salario..vigencia = "04/2020",      
    );
    assert(update.modified > 0);

    final delete = await clientSalarios.delete(salario.id);
    assert(delete.removed > 0);
  });
}
