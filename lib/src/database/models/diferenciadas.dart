import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:flutter_utils/sqlite_generator/sqlite_generator.dart';
import 'package:marcaii_flutter/src/utils/json_utils.dart';

class Diferenciadas {
  Diferenciadas({
    this.id,
    this.emprego_id,
    this.porc = 100,
    this.weekday = 6,
    this.vigencia = "01/2020",
    this.ativo = true,
  });

  factory Diferenciadas.fromMap(Map<String, dynamic> map) {
    return Diferenciadas(
      id: map['id'] as int,
      emprego_id: map['emprego_id'] as int,
      porc: map['porc'] as int,
      weekday: map['weekday'] as int,
      vigencia: map['vigencia'] as String,
      ativo: intToBool(map['ativo'] as int),
    );
  }

  int id, emprego_id, porc, weekday;
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ID: id,
      EMPREGO_ID: emprego_id,
      PORC: porc,
      WEEKDAY: weekday,
      VIGENCIA: vigencia,
      ATIVO: boolToInt(ativo),
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
}
