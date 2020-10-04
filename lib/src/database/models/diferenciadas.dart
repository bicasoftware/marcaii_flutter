import 'dart:convert';

import 'package:flutter_utils/sqlite_generator/sqlite_generator.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';

class Diferenciadas {
  Diferenciadas({
    this.id,
    this.emprego_id,
    this.porc = 100,
    this.weekday = 6,
    this.vigencia = "01/2020",
    this.ativo = true,
  });

  factory Diferenciadas.fromJson(String source) => Diferenciadas.fromMap(json.decode(source));

  factory Diferenciadas.fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }

    return Diferenciadas(
      id: map['id'],
      emprego_id: map['emprego_id'],
      porc: map['porc'],
      weekday: map['weekday'],
      vigencia: map['vigencia'],
      ativo: map['ativo'],
    );
  }

  int id;
  int emprego_id;
  int porc;
  int weekday;
  String vigencia;
  bool ativo;

  static const String ID = "id";
  static const String EMPREGO_ID = "emprego_id";
  static const String PORC = "porc";
  static const String WEEKDAY = "weekday";
  static const String VIGENCIA = "vigencia";
  static const String ATIVO = "ativo";

  static List<String> get columns => [ID, EMPREGO_ID, PORC, WEEKDAY, VIGENCIA, ATIVO];

  static String createSQL = SqliteTable(
    tableName,
    columns: {
      ID: SqliteColumn(ColumnTypes.PRIMARY_KEY),
      EMPREGO_ID: SqliteColumn(ColumnTypes.INTEGER, nullable: false),
      PORC: SqliteColumn(ColumnTypes.INTEGER, nullable: false, defaultValue: 100),
      WEEKDAY: SqliteColumn(ColumnTypes.INTEGER, nullable: false, defaultValue: 6),
      VIGENCIA: SqliteColumn(ColumnTypes.TEXT, nullable: false),
      ATIVO: SqliteColumn(ColumnTypes.INTEGER, nullable: false, defaultValue: 1),
    },
    fk: SqliteFK(
      referenceTable: Empregos.tableName,
      slaveColumn: EMPREGO_ID,
      masterColumn: Empregos.ID,
      onDelete: ConstraintTypes.CASCADE,
      onUpdate: ConstraintTypes.CASCADE,
    ),
  ).makeCreateQuery();

  static String tableName = "diferenciadas";

  Map<String, Object> toMap() {
    return {
      'id': id,
      'emprego_id': emprego_id,
      'porc': porc,
      'weekday': weekday,
      'vigencia': vigencia,
      'ativo': ativo,
    };
  }

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    if (other is Diferenciadas) {
      return porc == other.porc &&
          weekday == other.weekday &&
          vigencia == other.vigencia &&
          ativo == other.ativo;
    } else {
      return false;
    }
  }

  String toJson() => json.encode(toMap());
}
