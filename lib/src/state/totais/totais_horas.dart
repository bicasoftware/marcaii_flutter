import 'package:flutter/foundation.dart';

@immutable
class TotaisHoras {
  const TotaisHoras({
    this.minutes,
    this.date,
    this.valor,
    this.tipohora,
  });

  final int minutes, tipohora;
  final DateTime date;
  final double valor;
}
