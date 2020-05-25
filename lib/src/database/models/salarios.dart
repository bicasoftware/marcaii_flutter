import 'package:json_annotation/json_annotation.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/column_types.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/constraint_types.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/sqlite_column.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/sqlite_fk.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/sqlite_table.dart';
import 'package:marcaii_flutter/src/utils/json_utils.dart';

part 'salarios.g.dart';

@JsonSerializable(nullable: true)
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
      id: map['id'] as int,
      emprego_id: map['emprego_id'] as int,
      valor: map['valor'] as double,
      vigencia: map['vigencia'] as String,
      ativo: intToBool(map['ativo'] as int),
    );
  }

  int id, emprego_id;
  @JsonKey(fromJson: double.tryParse)
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

  static Salarios fromJson(Map<String, Object> json) {
    return _$SalariosFromJson(json);
  }

  Map<String, Object> toJson() {
    return _$SalariosToJson(this);
  }

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
