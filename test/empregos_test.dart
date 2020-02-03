import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/server/clients/empregos_client.dart';
import 'package:marcaii_flutter/src/server/clients/user_client.dart';
import 'package:marcaii_flutter/src/server/models/user_dto.dart';

void main() {
  test('periodos teste', () async {
    try {
      final dio = Dio();
      final authClient = UserClient(dio);

      final user = await authClient.authenticate(
          UserDto(email: "saulo@teste.com", password: "S17h05a8", username: "sauloandrioli"));

      dio.options.headers['Authorization'] = "Bearer ${user.token}";
      final empregosClient = EmpregosClient(dio);

      var emprego = Empregos(
          ativo: true,
          banco_horas: false,
          carga_horaria: 220,
          fechamento: 25,
          nome: "Analista de Sistemas",
          porc: 50,
          porc_completa: 100,
          saida: "20:00");

      emprego = await empregosClient.post(emprego);

      assert(emprego.id != null);

      final empregos = await empregosClient.fetch();
      assert(empregos.isNotEmpty);

      final update = await empregosClient.put(empregos[0].id, empregos[0]);

      final delete = await empregosClient.delete(empregos[0].id);

      assert(update.modified == 1);
      assert(delete.removed == 1);
    } catch (e) {
      if (e is DioError) {
        print(e.response.data);
      }
    }
  });
}
