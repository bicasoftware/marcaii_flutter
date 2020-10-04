import 'package:flutter_test/flutter_test.dart';
import 'package:marcaii_flutter/src/connection/dio_provider.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/database/models/insert_result.dart';
import 'package:marcaii_flutter/src/services/service_emprego.dart';
import 'package:marcaii_flutter/src/services/service_horas.dart';

void main() {
  const baseUrl = "http://localhost:3333";
  test('find server', () async {
    final result = await provideDio().get<Map>(baseUrl);

    if (result.statusCode == 200) {
      print(result.data['status']);
    }
  });

  test('list empregos', () async {
    final empregos = await ServiceEmprego().fetchEmpregos();
    assert(empregos != null);
    assert(empregos is List<Empregos>);
  });

  test('list hora', () async {
    final result = await ServiceHoras().fetchHora(4);
    assert(result != null);
    assert(result is List<Horas>);
  });

  test('post hora', () async {
    final hora = Horas(
      data: DateTime(2020, 05, 12),
      emprego_id: 4,
      inicio: "18:00",
      termino: "19:00",
      tipo: 0,
    );

    final result = await ServiceHoras().post(hora);
    assert(result != null);
    assert(result is InsertResult);
  });
}
