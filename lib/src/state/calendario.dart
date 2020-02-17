import 'package:marcaii_flutter/src/state/calendario_item.dart';

class Calendario {
  Calendario(this.vigencia, this.items);

  final String vigencia;
  final List<CalendarioChild> items;
}
