import 'package:flutter/foundation.dart';

@immutable
class TotaisItem {
  const TotaisItem({
    this.tipo,
    this.minutos,
    this.total,
    this.porcentagem,
    this.weekday,
  });

  final int tipo, minutos, porcentagem, weekday;
  final double total;
}
