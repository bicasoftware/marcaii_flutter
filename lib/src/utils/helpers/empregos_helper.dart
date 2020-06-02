import 'package:flutter/material.dart';
import 'package:marcaii_flutter/helpers.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/state/calendario/calendario.dart';
import 'package:marcaii_flutter/src/state/totais/totais.dart';
import 'package:marcaii_flutter/src/state/totais/totais_detalhes.dart';
import 'package:marcaii_flutter/src/state/totais/totais_horas.dart';
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

  List<Horas> _getHorasInRange(DateTime inicio, DateTime termino) {
    final end = termino.add(const Duration(days: 1));
    return horas
        .where((Horas h) => h.inicioAsDate.isAfter(inicio) && h.terminoAsDate.isBefore(end))
        .toList()
          ..sort((Horas a, Horas b) => a.data.compareTo(b.data));
  }

  double _calcTotal(int minutos, double salarioMinuto, int porcentagem) {
    return minutos * (salarioMinuto * (porcentagem / 100));
  }

  Totais generateTotais(Vigencia vigencia) {
    //Gera período do mês, ex: de 24/02/2020 até 25/03/2020
    final periodo = vigencia.getDateRange(fechamento);
    //Separa o início e o término
    final inicio = periodo[0];
    final termino = periodo[1];

    //calcula salário minuto
    final double salarioMinuto = CalcHelper.getSalarioMinuto(this, inicio);
    //Lista horas extras no período e ordena por data
    final horasPeriodo = _getHorasInRange(inicio, termino);
    horasPeriodo.sort((Horas a, Horas b) => a.data.compareTo(b.data));

    final totalNormal = TotaisDetalhe(
      minutos: 0,
      total: 0.0,
      porcentagem: porc,
      weekday: null,
      horas: [],
    );

    final totalFeriados = TotaisDetalhe(
      weekday: null,
      porcentagem: porc_completa,
      minutos: 0,
      total: 0.0,
      horas: [],
    );

    final totalGeral = TotaisDetalhe(
      weekday: null,
      porcentagem: null,
      total: 0.0,
      minutos: 0,
      horas: [],
    );

    final difer = <TotaisDetalhe>[];

    for (final hora in horasPeriodo) {
      final minutos = hora.difMinutes();
      double total = 0;
      if (hora.tipo == 0) {
        total = _calcTotal(minutos, salarioMinuto, porc);
        totalNormal.update(total: total, minutos: minutos, hora: hora);
      } else if (hora.tipo == 1) {
        total = _calcTotal(minutos, salarioMinuto, porc_completa);
        totalFeriados.update(total: total, minutos: minutos, hora: hora);
      } else if (hora.tipo == 2) {
        final i = difer.indexWhere((dif) => hora.data.indexWeekday() == dif.weekday);
        final difPorc = diferenciadas.firstWhere((d) => d.weekday == hora.data.indexWeekday()).porc;
        total = _calcTotal(minutos, salarioMinuto, difPorc);

        if (i >= 0) {
          difer[i].update(
            hora: hora,
            minutos: minutos,
            total: total,
          );
        } else {
          difer.add(
            TotaisDetalhe(
              weekday: hora.data.indexWeekday(),
              porcentagem: difPorc,
              minutos: minutos,
              total: total,
              horas: [
                TotaisHoras(
                  date: hora.data,
                  minutes: minutos,
                  tipohora: hora.tipo,
                  valor: total,
                ),
              ],
            ),
          );
        }
      }

      totalGeral.update(hora: hora, minutos: minutos, total: total);
    }

    return Totais(
      inicio: inicio,
      termino: termino,
      mes: vigencia.mes,
      normais: totalNormal,
      feriados: totalFeriados,
      difer: difer,
      totaisGeral: totalGeral,
    );
  }
}
