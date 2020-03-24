import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:marcaii_flutter/src/database/models/diferenciadas.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/database/models/model.dart';
import 'package:marcaii_flutter/src/database/models/salarios.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/column_types.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/sqlite_column.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/sqlite_table.dart';
import 'package:marcaii_flutter/src/state/calendario.dart';
import 'package:marcaii_flutter/src/state/calendario_item.dart';
import 'package:marcaii_flutter/src/utils/calendar_generator.dart';
import 'package:marcaii_flutter/src/utils/helpers/time_helper.dart';
import 'package:marcaii_flutter/src/utils/json_utils.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';
import 'package:marcaii_flutter/helpers.dart';

part 'empregos.g.dart';

@immutable
@JsonSerializable(nullable: true)
class Empregos implements Model<Empregos> {
  const Empregos({
    this.id,
    this.nome,
    this.porc = 50,
    this.porc_completa = 100,
    this.fechamento = 25,
    this.banco_horas = false,
    this.saida = "17:00",
    this.carga_horaria = 220,
    this.ativo = true,
    this.horas,
    this.diferenciadas,
    this.salarios,
    this.calendario,
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

  final String nome, saida;
  final int id, porc, porc_completa, fechamento, carga_horaria;
  final List<Horas> horas;
  final List<Diferenciadas> diferenciadas;
  final List<Salarios> salarios;
  @JsonKey(ignore: true)
  final List<Calendario> calendario;

  // @JsonKey(toJson: boolToInt, fromJson: intToBool)
  final bool banco_horas;

  // @JsonKey(toJson: boolToInt, fromJson: intToBool)
  final bool ativo;

  static const String ID = "id";
  static const String NOME = "nome";
  static const String PORC = "porc";
  static const String PORC_COMPLETA = "porc_completa";
  static const String FECHAMENTO = "fechamento";
  static const String BANCO_HORAS = "banco_horas";
  static const String SAIDA = "saida";
  static const String CARGA_HORARIA = "carga_horaria";
  static const String ATIVO = "ativo";

  Empregos forFirstSync() {
    return Empregos(
      id: null,
      nome: this.nome,
      porc: this.porc,
      porc_completa: this.porc_completa,
      fechamento: this.fechamento,
      banco_horas: this.banco_horas,
      saida: this.saida,
      carga_horaria: this.carga_horaria,
      ativo: this.ativo,
      horas: [],
      salarios: [],
      diferenciadas: [],
    );
  }

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
    List<Horas> horas,
    List<Salarios> salarios,
    List<Diferenciadas> diferenciadas,
    List<Calendario> calendario,
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
      horas: horas ?? this.horas,
      diferenciadas: diferenciadas ?? this.diferenciadas,
      salarios: salarios ?? this.salarios,
      calendario: calendario ?? this.calendario,
    );
  }

  static const columns = [
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

  @override
  String get createSQL {
    return SqliteTable(tableName, columns: {
      ID: SqliteColumn(ColumnTypes.PRIMARY_KEY),
      NOME: SqliteColumn(ColumnTypes.TEXT, nullable: false, defaultValue: "Emprego"),
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

  ///Usar com Sqlite
  Map<String, Object> toMap() {
    return {
      ID: this.id,
      NOME: this.nome,
      SAIDA: this.saida,
      PORC: this.porc,
      PORC_COMPLETA: this.porc_completa,
      FECHAMENTO: this.fechamento,
      CARGA_HORARIA: this.carga_horaria,
      BANCO_HORAS: boolToInt(this.banco_horas),
      ATIVO: boolToInt(this.ativo),
    };
  }

  bool equals(Empregos emprego, List<Salarios> salarios, List<Diferenciadas> diferenciadas) {
    final isSameEmprego = this.nome == emprego.nome &&
        this.porc == emprego.porc &&
        this.porc_completa == emprego.porc_completa &&
        this.fechamento == emprego.fechamento &&
        this.banco_horas == emprego.banco_horas &&
        this.saida == emprego.saida &&
        this.carga_horaria == emprego.carga_horaria &&
        this.ativo == emprego.ativo;

    final changedSalarios = listEquals(this.salarios, salarios);
    final changedDiferenciadas = listEquals(emprego.diferenciadas, diferenciadas);

    return isSameEmprego && changedSalarios && changedDiferenciadas;
  }

  Calendario getCalendario(String vigencia) {
    final index = calendario.indexWhere((c) => c.vigencia == vigencia);

    if (index < 0) {
      final vig = Vigencia.fromString(vigencia);
      final calendarioItems = CalendarGenerator.generate(vig.ano, vig.mes, horas);
      calendario.add(Calendario(vigencia: vigencia, items: calendarioItems));
    }

    return calendario.firstWhere((c) => c.vigencia == vigencia);
  }

  TimeOfDay get horaSaida => stringToTimeOfDay(saida);

  void addHora(Horas hora, Vigencia vigencia) {
    horas.add(hora);
    final c = calendario.firstWhere((c) => c.vigencia == vigencia.vigencia);
    final cIndex = calendario.indexOf(c);
    final items = [...c.items];
    final itemIndex = items.indexWhere((item) => item.date.isSameDate(hora.data));
    items.replaceRange(itemIndex, itemIndex + 1, [CalendarioChild(hora: hora, date: hora.data)]);

    calendario.replaceRange(cIndex, cIndex + 1, [c.copyWith(items: items)]);
  }

  void updateHora(Horas hora) {
    final index = horas.indexWhere((h) => h.id == hora.id);
    horas.replaceRange(index, index + 1, [hora]);
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
