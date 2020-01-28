import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/database/models/model.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/column_types.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/sqlite_column.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/sqlite_table.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:marcaii_flutter/src/utils/json_utils.dart';

part 'empregos.g.dart';

@immutable
@JsonSerializable(nullable: true)
class Empregos implements Model<Empregos> {
  const Empregos({
    this.nome,
    this.id,
    this.porc = 50,
    this.porc_completa = 100,
    this.fechamento = 25,
    this.banco_horas = false,
    this.saida = "17:00",
    this.carga_horaria = 220,
    this.ativo = true,
  });

  final String nome, saida;
  final int id, porc, porc_completa, fechamento, carga_horaria;

  @JsonKey(toJson: boolToInt, fromJson: intToBool)
  final bool banco_horas;

  @JsonKey(toJson: boolToInt, fromJson: intToBool)
  final bool ativo;

  static const String ID = "id";
  static const String PORC = "porc";
  static const String PORC_COMPLETA = "porc_completa";
  static const String FECHAMENTO = "fechamento";
  static const String BANCO_HORAS = "banco_horas";
  static const String SAIDA = "saida";
  static const String CARGA_HORARIA = "carga_horaria";
  static const String ATIVO = "ativo";

  Empregos copyWith({
    int id,
    String nome,
    int porc,
    int porc_completa,
    int fechamento,
    bool banco_horas,
    String saida,
    int carga_horaria,
    bool ativo,
  }) {
    return Empregos(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      porc: porc ?? this.porc,
      porc_completa: porc_completa ?? this.porc_completa,
      fechamento: fechamento ?? this.fechamento,
      banco_horas: banco_horas ?? this.banco_horas,
      saida: saida ?? this.saida,
      carga_horaria: carga_horaria ?? this.carga_horaria,
      ativo: ativo ?? this.ativo,
    );
  }

  static const columns = [
    ID,
    PORC,
    PORC_COMPLETA,
    FECHAMENTO,
    BANCO_HORAS,
    SAIDA,
    CARGA_HORARIA,
    ATIVO
  ];

  @override
  String get createSQL {
    return SqliteTable(tableName, columns: {
      ID: SqliteColumn(ColumnTypes.PRIMARY_KEY),
      PORC: SqliteColumn(ColumnTypes.INTEGER, nullable: false, defaultValue: 50),
      PORC_COMPLETA: SqliteColumn(ColumnTypes.INTEGER, nullable: false, defaultValue: 100),
      FECHAMENTO: SqliteColumn(ColumnTypes.INTEGER, nullable: false, defaultValue: 25),
      BANCO_HORAS: SqliteColumn(ColumnTypes.INTEGER, nullable: false, defaultValue: 0),
      SAIDA: SqliteColumn(ColumnTypes.TEXT, nullable: false, defaultValue: "17:00"),
      CARGA_HORARIA: SqliteColumn(ColumnTypes.INTEGER, nullable: false, defaultValue: 220),
      ATIVO: SqliteColumn(ColumnTypes.INTEGER, nullable: false, defaultValue: 1),
    }).generateCreateQuery();
  }

  static Empregos fromJson(Map<String, Object> json) {
    return _$EmpregosFromJson(json);
  }

  static const String tableName = "empregos";

  Map<String, Object> toJson() => _$EmpregosToJson(this);
}
