import 'package:flutter/material.dart';
import 'package:marcaii_flutter/helpers.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/state/calendario/calendario.dart';
import 'package:marcaii_flutter/src/state/totais/totais.dart';
import 'package:marcaii_flutter/src/state/totais/totais_detalhes.dart';
import 'package:marcaii_flutter/src/utils/calendar_generator.dart';
import 'package:marcaii_flutter/src/utils/helpers/time_helper.dart';
import 'package:marcaii_flutter/src/utils/hora_calc.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';

extension EmpregoHelper on Empregos {
  Empregos forFirstSync() {
    return Empregos(
      id: null,
      nome: nome,
      porc: porc,
      porc_completa: porc_completa,
      fechamento: fechamento,
      banco_horas: banco_horas,
      saida: saida,
      carga_horaria: carga_horaria,
      ativo: ativo,
      horas: [],
      salarios: [],
      diferenciadas: [],
    );
  }

  TimeOfDay get horaSaida => stringToTimeOfDay(saida);

  Calendario getCalendario(Vigencia vigencia) {
    ///Testa se já existe alguma página do calendário adicionada.
    final index = calendario.indexWhere((c) => vigencia.compare(c.vigencia));

    ///Se não houver, faz a relação dos dias do mes com a [Horas] conforme a [Vigencia]
    if (index < 0) {
      final c = Calendario(
        vigencia: vigencia.vigencia,
        items: CalendarGenerator.generate(vigencia.ano, vigencia.mes, horas),
      );
      calendario.add(c);
      return c;
    } else {
      return calendario[index];
    }
  }

  List<Horas> getHorasInRange(DateTime inicio, DateTime termino) {
    final end = termino.add(const Duration(days: 1));
    return horas
        .where((Horas h) => h.inicioAsDate.isAfter(inicio) && h.terminoAsDate.isBefore(end))
        .toList()
          ..sort((Horas a, Horas b) => a.data.compareTo(b.data));
  }

  Totais generateTotais(Vigencia vigencia) {
    final periodo = vigencia.getDateRange(fechamento);
    final inicio = periodo[0];
    final termino = periodo[1];

    final double salarioMinuto = CalcHelper.getSalarioMinuto(this, inicio);
    final double valorPorcNormal = salarioMinuto * (porc / 100);
    final double valorPorcCompleta = salarioMinuto * (porc_completa / 100);

    final horasPeriodo = getHorasInRange(inicio, termino);
    horasPeriodo.sort((Horas a, Horas b) => a.data.compareTo(b.data));

    final minutesNormal = horasPeriodo
        .where((e) => e.tipo == 0)
        .fold<int>(0, (int t, Horas n) => t + n.difMinutes() ?? 0);

    final totalReceberNormal = valorPorcNormal * minutesNormal;
    final minutesFeriados = horasPeriodo
        .where((e) => e.tipo == 1)
        .fold<int>(0, (int t, Horas n) => t + n.difMinutes() ?? 0);
    final totalReceberFeriados = valorPorcCompleta * minutesFeriados;

    final minutesDif = horasPeriodo
        .where((e) => e.tipo == 2)
        .fold<int>(0, (int t, Horas n) => t + n.difMinutes() ?? 0);

    double totalDifer = 0;

    final difer = <TotaisDetalhe>[];

    for (final d in diferenciadas) {
      final list =
          horasPeriodo.where((h) => h.tipo == 2 && h.data.indexWeekday() == d.weekday).toList();
      final difMin = list.fold<int>(0, (int t, Horas n) => t + n.difMinutes() ?? 0);
      final valorDifHora = salarioMinuto * (d.porc / 100);
      final totDif = difMin * valorDifHora;
      totalDifer += totDif;
      difer.add(
        TotaisDetalhe(
          minutos: difMin,
          total: totDif,
          porcentagem: d.porc,
          weekday: d.weekday,
          horas: list,
        ),
      );
    }

    return Totais(
      inicio: inicio,
      termino: termino,
      mes: vigencia.mes,
      totaisGeral: TotaisDetalhe(
        weekday: null,
        total: totalReceberNormal + totalReceberFeriados + totalDifer,
        minutos: minutesNormal + minutesDif + minutesFeriados,
        porcentagem: null,
        horas: horasPeriodo,
      ),
      normais: TotaisDetalhe(
        minutos: minutesNormal,
        total: totalReceberNormal,
        porcentagem: porc,
        weekday: null,
        horas: horasPeriodo.where((Horas h) => h.tipo == 0).toList(),
      ),
      feriados: TotaisDetalhe(
        minutos: minutesFeriados,
        total: totalReceberFeriados,
        porcentagem: porc_completa,
        weekday: null,
        horas: horasPeriodo.where((Horas h) => h.tipo == 1).toList(),
      ),
      difer: difer,
    );
  }
}
