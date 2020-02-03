import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/server/clients/horas_client.dart';
import 'package:marcaii_flutter/src/server/clients/user_client.dart';
import 'package:marcaii_flutter/src/server/models/user_dto.dart';
import 'package:marcaii_flutter/helpers.dart';

void main() {
  test('horas test', () async {
    final dio = Dio();
    final authClient = UserClient(dio);
    final userData = await authClient.authenticate(UserDto(
      email: "saulo@test.com",
      password: "S17h05a8",
      username: "sauloandrioli",
    ));

    dio.options.headers['Authorization'] = "Bearer ${userData.token}";
    final empregoId = userData.empregos.first.id;

    final clientHoras = HorasClient(dio);
    var hora = Horas(
      emprego_id: empregoId,
      data: DateTime.now(),
    );

    hora = await clientHoras.insert(hora);

    assert(hora.id != null);

    final horas = await clientHoras.fetchHoras(empregoId);
    assert(horas is List<Horas>);
    assert(horas.isNotEmpty);

    final updatehora = await clientHoras.updateHora(hora.id, hora);
    assert(updatehora.modified > 0);

    final deletehora = await clientHoras.deleteHora(hora.id);
    assert(deletehora.isNotNull);
    assert(deletehora.removed > 0);
  });
}
