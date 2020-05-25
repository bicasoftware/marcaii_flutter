import 'package:json_annotation/json_annotation.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/column_types.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/constraint_types.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/sqlite_column.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/sqlite_fk.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/sqlite_table.dart';

part 'horas.g.dart';

@JsonSerializable(nullable: true)
class Horas {
  Horas({
    this.emprego_id,
    this.data,
    this.id,
    this.tipo = 0,
    this.inicio = "17:00",
    this.termino = "18:00",
  });

  int id, emprego_id, tipo;
  String inicio, termino;
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

  static Horas fromJson(Map<String, Object> json) {
    return _$HorasFromJson(json);
  }

  static String get tableName => "horas";

  Map<String, Object> toJson() => _$HorasToJson(this);
}
