import 'package:marcaii_flutter/src/database/models/horas.dart';

class CalendarioChild {
  CalendarioChild({
    this.date,
    this.hora,
  });

  DateTime date;
  Horas hora;

  void setHora(Horas hora) => this.hora = hora;
}
