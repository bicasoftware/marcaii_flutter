import 'package:flutter_utils/sqlite_generator/sqlite_generator.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:flutter_utils/sugarmap/sugarmap.dart';

class Salarios {
  Salarios({
    this.id,
    this.emprego_id,
    this.valor,
    this.vigencia,
    this.ativo,
  });

  factory Salarios.fromMap(Map<String, dynamic> map) {
    return Salarios(
      id: map.asInt('id'),
      emprego_id: map.asInt('emprego_id'),
      valor: map.asDouble('valor'),
      vigencia: map.asString('vigencia'),
      ativo: map.asBoolFromInt('ativo'),
    );
  }

  int id;
  int emprego_id;
  double valor;
  String vigencia;
  bool ativo;

  static const String ID = "id";
  static const String EMPREGO_ID = "emprego_id";
  static const String VALOR = "valor";
  static const String VIGENCIA = "vigencia";
  static const String ATIVO = "ativo";
  static const String tableName = "salarios";

  static const List<String> columns = [ID, EMPREGO_ID, VALOR, VIGENCIA, ATIVO];

  static String createSQL = SqliteTable(
    tableName,
    columns: {
      ID: SqliteColumn(ColumnTypes.PRIMARY_KEY),
      EMPREGO_ID: SqliteColumn(ColumnTypes.INTEGER),
      VALOR: SqliteColumn(ColumnTypes.REAL),
      VIGENCIA: SqliteColumn(ColumnTypes.TEXT),
      ATIVO: SqliteColumn(ColumnTypes.INTEGER),
    },
    fk: SqliteFK(
      referenceTable: Empregos.tableName,
      slaveColumn: EMPREGO_ID,
      masterColumn: Empregos.ID,
      onDelete: ConstraintTypes.CASCADE,
      onUpdate: ConstraintTypes.CASCADE,
    ),
  ).makeCreateQuery();

  Map<String, Object> toMap() {
    return {
      ID: id,
      EMPREGO_ID: emprego_id,
      VALOR: valor,
      VIGENCIA: vigencia,
      ATIVO: boolToInt(ativo),
    };
  }

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Salarios &&
            runtimeType == other.runtimeType &&
            valor == other.valor &&
            vigencia == other.vigencia &&
            ativo == other.ativo;
  }

  @override
  String toString() {
    return """ id: $id, emprego_id: $emprego_id, valor: $valor, vigencia: $vigencia ativo:$ativo """;
  }
}
