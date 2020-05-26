import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:marcaii_flutter/helpers.dart';
import 'package:marcaii_flutter/src/database/models/diferenciadas.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/database/models/salarios.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/column_types.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/sqlite_column.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/sqlite_table.dart';
import 'package:marcaii_flutter/src/state/calendario/calendario.dart';
import 'package:marcaii_flutter/src/state/calendario/calendario_child.dart';
import 'package:marcaii_flutter/src/state/totais/totais.dart';
import 'package:marcaii_flutter/src/utils/json_utils.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';

part 'empregos.g.dart';

@JsonSerializable(nullable: true)
class Empregos {
  Empregos({
    this.id,
    this.nome,
    this.porc = 50,
    this.porc_completa = 100,
    this.fechamento = 25,
    this.banco_horas = false,
    this.saida = '17:00',
    this.carga_horaria = 220,
    this.ativo = true,
    this.horas,
    this.diferenciadas,
    this.salarios,
    this.calendario,
    this.totais,
  });

  factory Empregos.fromMap(Map<String, dynamic> map) {
    return Empregos(
      id: map['id'] as int,
      nome: map['nome'] as String,
      porc: map['porc'] as int,
      porc_completa: map['porc_completa'] as int,
      fechamento: map['fechamento'] as int,
      banco_horas: intToBool(map['banco_horas'] as int),
      saida: map['saida'] as String,
      carga_horaria: map['carga_horaria'] as int,
      ativo: intToBool(map['ativo'] as int),
    );
  }

  String nome, saida;
  int id, porc, porc_completa, fechamento, carga_horaria;
  List<Horas> horas;
  List<Diferenciadas> diferenciadas;
  List<Salarios> salarios;
  @JsonKey(ignore: true)
  List<Calendario> calendario;
  @JsonKey(ignore: true)
  Totais totais;
  bool banco_horas;
  bool ativo;

  static const String ID = "id";
  static const String NOME = "nome";
  static const String PORC = "porc";
  static const String PORC_COMPLETA = "porc_completa";
  static const String FECHAMENTO = "fechamento";
  static const String BANCO_HORAS = "banco_horas";
  static const String SAIDA = "saida";
  static const String CARGA_HORARIA = "carga_horaria";
  static const String ATIVO = "ativo";

  static const List<String> columns = [
    ID,
    NOME,
    PORC,
    PORC_COMPLETA,
    FECHAMENTO,
    BANCO_HORAS,
    SAIDA,
    CARGA_HORARIA,
    ATIVO
  ];

  static String createSQL = SqliteTable(
    tableName,
    columns: {
      ID: SqliteColumn(ColumnTypes.PRIMARY_KEY),
      NOME: SqliteColumn(ColumnTypes.TEXT, nullable: false, defaultValue: "Emprego"),
      PORC: SqliteColumn(ColumnTypes.INTEGER, nullable: false, defaultValue: 50),
      PORC_COMPLETA: SqliteColumn(ColumnTypes.INTEGER, nullable: false, defaultValue: 100),
      FECHAMENTO: SqliteColumn(ColumnTypes.INTEGER, nullable: false, defaultValue: 25),
      BANCO_HORAS: SqliteColumn(ColumnTypes.INTEGER, nullable: false, defaultValue: 0),
      SAIDA: SqliteColumn(ColumnTypes.TEXT, nullable: false, defaultValue: "17:00"),
      CARGA_HORARIA: SqliteColumn(ColumnTypes.INTEGER, nullable: false, defaultValue: 220),
      ATIVO: SqliteColumn(ColumnTypes.INTEGER, nullable: false, defaultValue: 1),
    },
    fk: null,
  ).makeCreateQuery();

  static Empregos fromJson(Map<String, Object> json) {
    return _$EmpregosFromJson(json);
  }

  static const String tableName = "empregos";

  Map<String, Object> toJson() => _$EmpregosToJson(this);

  ///Usar com Sqlite
  Map<String, Object> toMap() {
    return {
      ID: id,
      NOME: nome,
      SAIDA: saida,
      PORC: porc,
      PORC_COMPLETA: porc_completa,
      FECHAMENTO: fechamento,
      CARGA_HORARIA: carga_horaria,
      BANCO_HORAS: boolToInt(banco_horas),
      ATIVO: boolToInt(ativo),
    };
  }

  bool equals(Empregos emprego, List<Salarios> salarios, List<Diferenciadas> diferenciadas) {
    final isSameEmprego = nome == emprego.nome &&
        porc == emprego.porc &&
        porc_completa == emprego.porc_completa &&
        fechamento == emprego.fechamento &&
        banco_horas == emprego.banco_horas &&
        saida == emprego.saida &&
        carga_horaria == emprego.carga_horaria &&
        ativo == emprego.ativo;

    final changedSalarios = listEquals(this.salarios, salarios);
    final changedDiferenciadas = listEquals(this.diferenciadas, diferenciadas);

    return isSameEmprego && changedSalarios && changedDiferenciadas;
  }

  void addHora(Horas hora, Vigencia vigencia) {
    horas.add(hora);
    calendario
        .firstWhere((c) => c.vigencia == vigencia.vigencia)
        .items
        .firstWhere((CalendarioChild child) => child.date.isSameDate(hora.data))
        .setHora(hora);
  }

  void updateHora(Horas hora) {
    horas.firstWhere((Horas h) => h.id == hora.id)
      ..tipo = hora.tipo
      ..inicio = hora.inicio
      ..termino = hora.termino;
  }

  void removeHora(Horas hora) {
    horas.removeWhere((h) => h.id == hora.id);
  }

  void addSalario(Salarios salario) {
    salarios.add(salario);
  }

  void addDiferenciada(Diferenciadas dif) {
    diferenciadas.add(dif);
  }
}
