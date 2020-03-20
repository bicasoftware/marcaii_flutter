import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:marcaii_flutter/src/database/models/model.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/column_types.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/sqlite_column.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/sqlite_table.dart';
import 'package:marcaii_flutter/src/utils/json_utils.dart';

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

  static Diferenciadas fromJson(Map<String, Object> json) {
    return _$DiferenciadasFromJson(json);
  }

  // ignore: prefer_constructors_over_static_methods
  static Diferenciadas fromMap(Map<String, dynamic> map) {
    return Diferenciadas(
      id: map['id'] as int,
      emprego_id: map['emprego_id'] as int,
      porc: map['porc'] as int,
      weekday: map['weekday'] as int,
      vigencia: map['vigencia'] as String,
      ativo: intToBool(map['ativo'] as int),
    );
  }

  final int id, emprego_id, porc, weekday;
  final String vigencia;
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

  Diferenciadas forFirstSync(int emprego_id) {
    return Diferenciadas(
      id: null,
      emprego_id: emprego_id,
      porc: this.porc,
      weekday: this.weekday,
      vigencia: this.vigencia,
      ativo: this.ativo,
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

  static String tableName = "diferenciadas";

  Map<String, Object> toJson() => _$DiferenciadasToJson(this);

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Diferenciadas &&
            runtimeType == other.runtimeType &&
            this.porc == other.porc &&
            this.weekday == other.weekday &&
            this.vigencia == other.vigencia &&
            this.ativo == other.ativo;
  }
}
