import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marcaii_flutter/helpers.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/constraint_types.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/sqlite_fk.dart';
import 'package:marcaii_flutter/src/utils/double_utils.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';
import 'package:marcaii_flutter/src/views/widgets/form_validation.dart';

void main() {
  test('test email', () {
    const email = "saulo@test.com";
    assert(validateEmail(email) == null);
  });

  test('test password', () {
    const password = "S17h05a8.";
    assert(validatePassword(password) == null);
  });

  test('weekday', () {
    final dt = DateTime(2020, 02, 16);
    assert(dt.indexWeekday() == 0);
  });

  test('test regex', () {
    final v = currencyStringToDouble("R\$ 1300,54");
    assert(v == 1300.54);
  });

  test('regex salario', () {
    const str = "R\$ 0,00";
    final v = currencyStringToDouble(str);
    print(v);
  });

  test("list equals", () {
    final nomes = ["saulo", "henrique", "andrioli"];
    final nomes2 = ['saulo', "henrique", "andrioli"];
    const clientes = [
      Cliente(nome: "saulo", idade: 31),
      Cliente(nome: "josué", idade: 32),
    ];
    const clientes2 = [
      Cliente(nome: "saulo", idade: 31),
      Cliente(nome: "josué", idade: 32),
    ];
    const clientes3 = [
      Cliente(nome: "saulo2", idade: 103),
      Cliente(nome: "josu2", idade: 65),
    ];

    print(listEquals(nomes, nomes2));
    print(listEquals(clientes, clientes2));
    print(listEquals(nomes2, clientes3));
  });

  test('vigencia', () {
    final v1 = Vigencia(ano: 2020, mes: 5);
    final v2 = Vigencia.fromString("05/2020");
    final v3 = Vigencia.fromDateTime(DateTime(2020, 5, 1));
    print('v1: ${v1.vigenciaExtenso}');
    print('v2: ${v2.vigenciaExtenso}');
    print('v3: ${v3.vigenciaExtenso}');
    assert(v1.compare(v2) && v2.compare(v3));
    assert(v1.vigenciaExtenso == v2.vigenciaExtenso && v2.vigenciaExtenso == v3.vigenciaExtenso);
  });

  test('replace', () {
    final nomes = ["saulo", "andrioli", "silva", "souza"];
    final index = nomes.indexOf('saulo');
    nomes.replaceRange(index, index + 1, ["josué"]);
    print(nomes);
  });

  test('time of day compare', () {
    const init = TimeOfDay(hour: 19, minute: 0);
    const end = TimeOfDay(hour: 19, minute: 30);

    assert(init.isBefore(end));
  });

  test('date format', () {
    final dt = DateTime.now();
    print(dt.toIso8601String());
    print(dt.format());
    print(dt.formatAsDefault());
  });

  test('periodo range', () {
    final v = Vigencia(ano: 2020, mes: 1);
    final range = v.getDateRange(25);

    range.forEach((DateTime e) => print(e.toIso8601String()));
  });

  test('generate fk', () {
    final fk = SqliteFK(
      referenceTable: "empregos",
      slaveColumn: "id_emprego",
      masterColumn: "id",
      onDelete: ConstraintTypes.CASCADE,
      onUpdate: ConstraintTypes.CASCADE,
    );

    print(fk.generateFK());
  });
}

@immutable
class Cliente {
  const Cliente({this.nome, this.idade});

  final String nome;
  final int idade;
}
