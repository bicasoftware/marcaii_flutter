import 'package:flutter/foundation.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';

@immutable
class TotaisDetalhe {
  const TotaisDetalhe({
    @required this.minutos,
    @required this.total,
    @required this.porcentagem,
    @required this.weekday,
    @required this.horas,
  });

  final int minutos, porcentagem, weekday;
  final double total;
  final List<Horas> horas;
}
