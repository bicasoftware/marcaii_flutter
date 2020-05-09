import 'package:flutter/foundation.dart';

@immutable
class TotaisItemDiferenciadas {
  const TotaisItemDiferenciadas({
    @required this.minutos,
    @required this.porcentagem,
    @required this.weekday,
    @required this.total,
  });

  final int minutos, porcentagem, weekday;
  final double total;
}
