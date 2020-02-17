import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/strings.dart';

extension HoraHelper on Horas {
  Color getColor() => Consts.horaColor[this.tipo];
  String getTipo() => Consts.tipoHora[this.tipo];
}
