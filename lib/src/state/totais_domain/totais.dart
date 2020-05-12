import 'package:flutter/foundation.dart';
import 'package:marcaii_flutter/src/state/totais_domain/totais_detalhes.dart';

@immutable
class Totais {
  const Totais({
    @required this.mes,
    @required this.inicio,
    @required this.termino,
    @required this.minutos,
    @required this.totalReceber,
    @required this.normais,
    @required this.feriados,
    @required this.difer,
  });

  final int mes;
  final DateTime inicio, termino;
  final int minutos;
  final double totalReceber;
  final TotaisDetalhe normais, feriados;
  final List<TotaisDetalhe> difer;
}
