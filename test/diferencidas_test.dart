import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marcaii_flutter/src/database/models/diferenciadas.dart';
import 'package:marcaii_flutter/src/server/clients/diferenciadas_client.dart';
import 'package:marcaii_flutter/src/server/clients/user_client.dart';
import 'package:marcaii_flutter/src/server/models/user_dto.dart';

void main() {
  test('test diferenciadas', () async {
    final dio = Dio();
    final authClient = UserClient(dio);
    final user = UserDto(email: "saulo@test.com", password: "S17h05a8");

    final userData = await authClient.authenticate(user);

    dio.options.headers['Authorization'] = "Bearer ${userData.token}";
    final empregoId = userData.empregos.first.id;

    final clientDiferenciada = DiferenciadasClient(dio);

    var diferenciada = Diferenciadas(emprego_id: empregoId, porc: 110, vigencia: '03/2020');

    diferenciada = await clientDiferenciada.post(diferenciada);
    assert(diferenciada.id != null);

    final update = await clientDiferenciada.put(
      diferenciada.id,
      diferenciada..vigencia = '04/2020',
    );

    assert(update.modified > 0);

    final delete = await clientDiferenciada.delete(diferenciada.id);

    assert(delete.removed > 0);
  });
}
