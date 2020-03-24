import 'package:marcaii_flutter/src/database/models/horas.dart';

class CalendarioChild {
  CalendarioChild({
    this.date,
    this.hora,
  });

  final DateTime date;
  final Horas hora;

  CalendarioChild copyWith({
    DateTime date,
    Horas hora,
  }) {
    return CalendarioChild(
      date: date ?? this.date,
      hora: hora ?? this.hora,
    );
  }
}
