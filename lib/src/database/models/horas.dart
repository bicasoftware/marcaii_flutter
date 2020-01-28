import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/database/models/model.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/column_types.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/sqlite_column.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/sqlite_table.dart';
import 'package:json_annotation/json_annotation.dart';

part 'horas.g.dart';

@immutable
@JsonSerializable(nullable: true)
class Horas implements Model<Horas> {
  const Horas({
    this.emprego_id,
    this.data,
    this.id,
    this.tipo = 0,
    this.inicio = "17:00",
    this.termino = "18:00",
  });

  final int id, emprego_id, tipo;
  final String inicio, termino;
  final DateTime data;

  static const ID = "id";
  static const EMPREGO_ID = "emprego_id";
  static const TIPO = "tipo";
  static const INICIO = "inicio";
  static const TERMINO = "termino";
  static const DATA = "data";

  Horas copyWith({
    int id,
    int emprego_id,
    int tipo,
    String inicio,
    String termino,
    DateTime data,
  }) {
    return Horas(
      id: id ?? this.id,
      emprego_id: emprego_id ?? this.emprego_id,
      tipo: tipo ?? this.tipo,
      inicio: inicio ?? this.inicio,
      termino: termino ?? this.termino,
      data: data ?? this.data,
    );
  }

  DateTime mergeTimeNDateTime(String time, DateTime date) {
    final splitTime = time.split(":").map(int.parse).toList();
    return DateTime(
      date.year,
      date.month,
      date.day,
      splitTime[0],
      splitTime[1],
    );
  }

  DateTime get inicioAsDate => mergeTimeNDateTime(inicio, data);
  DateTime get terminoAsDate => mergeTimeNDateTime(inicio, data);

  bool hasValidDates() => this.inicioAsDate.isBefore(terminoAsDate);

  static get columns => [ID, TIPO, INICIO, TERMINO];

  @override
  String get createSQL {
    return SqliteTable(tableName, columns: {
      ID: SqliteColumn(ColumnTypes.PRIMARY_KEY),
      EMPREGO_ID: SqliteColumn(ColumnTypes.INTEGER, nullable: false),
      TIPO: SqliteColumn(ColumnTypes.INTEGER, nullable: false, defaultValue: 0),
      INICIO: SqliteColumn(ColumnTypes.TEXT, nullable: false, defaultValue: "17:00"),
      TERMINO: SqliteColumn(ColumnTypes.TEXT, nullable: false, defaultValue: "17:00"),
    }).generateCreateQuery();
  }

  static Horas fromJson(Map<String, Object> json) {
    return _$HorasFromJson(json);
  }

  static String get tableName => "horas";

  Map<String, Object> toJson() => _$HorasToJson(this);
}
