import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:marcaii_flutter/src/database/models/model.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/column_types.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/sqlite_column.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/sqlite_table.dart';

part 'diferenciadas.g.dart';

@immutable
@JsonSerializable(nullable: true)
class Diferenciadas implements Model<Diferenciadas> {
  const Diferenciadas({
    this.id,
    this.emprego_id,
    this.porc = 100,
    this.weekday = 6,
    this.vigencia = "01/2020",
    this.ativo = true,
  });

  final int id, emprego_id, porc, weekday;
  final String vigencia;
  // @JsonKey(toJson: boolToInt, fromJson: intToBool)
  final bool ativo;

  static const String ID = "id";
  static const String EMPREGO_ID = "emprego_id";
  static const String PORC = "porc";
  static const String WEEKDAY = "weekday";
  static const String VIGENCIA = "vigencia";
  static const String ATIVO = "ativo";

  Diferenciadas copyWith({
    int id,
    int emprego_id,
    int porc,
    int weekday,
    String vigencia,
    bool ativo,
  }) {
    return Diferenciadas(
      id: id ?? this.id,
      emprego_id: emprego_id ?? this.emprego_id,
      porc: porc ?? this.porc,
      weekday: weekday ?? this.weekday,
      vigencia: vigencia ?? this.vigencia,
      ativo: ativo ?? this.ativo,
    );
  }

  static get columns => [ID, EMPREGO_ID, PORC, WEEKDAY, VIGENCIA, ATIVO];

  @override
  String get createSQL {
    return SqliteTable(tableName, columns: {
      ID: SqliteColumn(ColumnTypes.PRIMARY_KEY),
      EMPREGO_ID: SqliteColumn(ColumnTypes.INTEGER, nullable: false),
      PORC: SqliteColumn(ColumnTypes.INTEGER, nullable: false, defaultValue: 100),
      WEEKDAY: SqliteColumn(ColumnTypes.INTEGER, nullable: false, defaultValue: 6),
      VIGENCIA: SqliteColumn(ColumnTypes.TEXT, nullable: false),
      ATIVO: SqliteColumn(ColumnTypes.INTEGER, nullable: false, defaultValue: 1),
    }).generateCreateQuery();
  }

  static Diferenciadas fromJson(Map<String, Object> json) {
    return _$DiferenciadasFromJson(json);
  }

  static String tableName = "diferenciadas";

  Map<String, Object> toJson() => _$DiferenciadasToJson(this);
}
