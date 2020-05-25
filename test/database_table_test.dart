import 'package:flutter_test/flutter_test.dart';
import 'package:marcaii_flutter/src/database/models/diferenciadas.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/database/models/salarios.dart';

void main() {
  group('sql generator', () {
    test('create table', () {
      final String diferenciada = Diferenciadas.createSQL;

      final String empregos = Empregos.createSQL;

      final String horas = Horas.createSQL;

      final String salarios = Salarios.createSQL;

      print("horas: \n $horas");
      print("empregos: \n $empregos");
      print("salarios: \n $salarios");
      print("diferenciadas: \n $diferenciada");
    });
  });
}
