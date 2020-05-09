import 'package:flutter/foundation.dart';
import 'package:marcaii_flutter/src/state/totais_domain/totais_item.dart';

@immutable
class Totais {
  const Totais({
    @required this.mes,
    @required this.inicio,
    @required this.termino,
    @required this.items,
  }) : assert(items.length >= 2);

  final int mes;
  final DateTime inicio, termino;
  final List<TotaisItem> items;
}
