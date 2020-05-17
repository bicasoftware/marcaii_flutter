import 'package:flutter/foundation.dart';
import 'package:marcaii_flutter/src/state/totais_domain/totais_detalhes.dart';

@immutable
class Totais {
  const Totais({
    @required this.mes,
    @required this.inicio,
    @required this.termino,
    @required this.normais,
    @required this.feriados,
    @required this.totaisGeral,
    @required this.difer,
  });

  final int mes;
  final DateTime inicio, termino;
  final TotaisDetalhe normais, feriados, totaisGeral;
  final List<TotaisDetalhe> difer;
}
