import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marcaii_flutter/src/utils/double_utils.dart';
import 'package:marcaii_flutter/src/views/shared/form_validation.dart';
import 'package:marcaii_flutter/helpers.dart';

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
}

@immutable
class Cliente {
  const Cliente({this.nome, this.idade});

  final String nome;
  final int idade;
}
