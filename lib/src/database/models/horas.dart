import 'dart:convert';

import 'package:flutter_utils/sqlite_generator/sqlite_generator.dart';
import 'package:intl/intl.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';

class Horas {
  Horas({
    this.emprego_id,
    this.data,
    this.id,
    this.tipo = 0,
    this.inicio = "17:00",
    this.termino = "18:00",
  });

  factory Horas.fromJson(String source) => Horas.fromMap(json.decode(source));

  factory Horas.fromMap(Map<String, Object> map) {
    if (map == null) {
      return null;
    }

    return Horas(
      id: map['id'],
      emprego_id: map['emprego_id'],
      tipo: map['tipo'],
      inicio: map['inicio'],
      termino: map['termino'],
      data: DateFormat('yyyy-MM-dd').parse(map['data']),
    );
  }

  int id;
  int emprego_id;
  int tipo;
  String inicio;
  String termino;
  DateTime data;

  static const ID = "id";
  static const EMPREGO_ID = "emprego_id";
  static const TIPO = "tipo";
  static const INICIO = "inicio";
  static const TERMINO = "termino";
  static const DATA = "data";

  static List<String> get columns => [ID, TIPO, INICIO, TERMINO];

  static String get createSQL {
    return SqliteTable(
      tableName,
      columns: {
        ID: SqliteColumn(ColumnTypes.PRIMARY_KEY),
        EMPREGO_ID: SqliteColumn(ColumnTypes.INTEGER, nullable: false),
        TIPO: SqliteColumn(ColumnTypes.INTEGER, nullable: false, defaultValue: 0),
        INICIO: SqliteColumn(ColumnTypes.TEXT, nullable: false, defaultValue: "17:00"),
        TERMINO: SqliteColumn(ColumnTypes.TEXT, nullable: false, defaultValue: "17:00"),
        DATA: SqliteColumn(ColumnTypes.TEXT, nullable: false, defaultValue: "2010-01-01"),
      },
      fk: SqliteFK(
        referenceTable: Empregos.tableName,
        slaveColumn: EMPREGO_ID,
        masterColumn: Empregos.ID,
        onDelete: ConstraintTypes.CASCADE,
        onUpdate: ConstraintTypes.CASCADE,
      ),
    ).makeCreateQuery();
  }

  @override
  String toString() {
    return "id: $id, emprego_id: $emprego_id, tipo: $tipo, inicio: $inicio, termino: $termino, data: $data";
  }

  static String get tableName => "horas";

  Map<String, Object> toMap() {
    return {
      'id': id,
      'emprego_id': emprego_id,
      'tipo': tipo,
      'inicio': inicio,
      'termino': termino,
      'data': DateFormat("yyyy-MM-dd").format(data),
    };
  }

  String toJson() => json.encode(toMap());

  static List<Horas> fromJsonList(List<Object> data) {
    return List<Horas>.from(
      data.map<Object>(
        (Object h) => Horas.fromJson(json.encode(h)),
      ),
    );
  }
}
