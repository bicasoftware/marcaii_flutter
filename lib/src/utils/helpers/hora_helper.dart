import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/strings.dart';

extension HoraHelper on Horas {
  Color getColor() => Consts.horaColor[tipo];
  String getTipo() => Consts.tipoHoraPlural[tipo];

  int difMinutes() {
    final iniMinutes = int.parse(inicio.substring(0, 2)) * 60 + int.parse(inicio.substring(3, 5));
    final endMinutes = int.parse(termino.substring(0, 2)) * 60 + int.parse(termino.substring(3, 5));
    return endMinutes - iniMinutes;
  }

  String difEstenso() {
    final dif = difMinutes();
    final horas = (dif / 60).floor();
    final minutes = dif % 60;

    return "${horas > 0 ? '$horas Horas' : ''}${horas > 0 && minutes > 0 ? ' e ' : ''}${minutes > 0 ? '$minutes Minutos' : ''}";
  }

  DateTime mergeTimeNDateTime(String time, DateTime date) {
    final splitTime = time.split(":").map(int.parse).toList();
    return DateTime(
      date.year,
      date.month,
      date.day,
      splitTime[0],
      splitTime[1],
    );
  }

  DateTime get inicioAsDate => mergeTimeNDateTime(inicio, data);
  DateTime get terminoAsDate => mergeTimeNDateTime(inicio, data);

  bool hasValidDates() => inicioAsDate.isBefore(terminoAsDate);

  Color get color => Consts.horaColor[tipo];
}
