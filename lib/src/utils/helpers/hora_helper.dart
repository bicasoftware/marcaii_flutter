import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/strings.dart';

extension HoraHelper on Horas {
  Color getColor() => Consts.horaColor[tipo];
  String getTipo() => Consts.tipoHora[tipo];

  int difMinutes() {
    final iniMinutes =
        int.parse(inicio.substring(0, 2)) * 60 + int.parse(inicio.substring(3, 5));
    final endMinutes =
        int.parse(termino.substring(0, 2)) * 60 + int.parse(termino.substring(3, 5));
    return endMinutes - iniMinutes;
  }

  String difEstenso() {
    final dif = difMinutes();
    final horas = (dif / 60).floor();
    final minutes = dif % 60;

    return "${horas > 0 ? '$horas Horas' : ''}${horas > 0 && minutes > 0 ? ' e ' : ''}${minutes > 0 ? '$minutes Minutos' : ''}";
  }
}
