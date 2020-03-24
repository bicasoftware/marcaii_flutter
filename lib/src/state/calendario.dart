import 'package:marcaii_flutter/src/state/calendario_item.dart';

class Calendario {
  Calendario({this.vigencia, this.items});

  final String vigencia;
  final List<CalendarioChild> items;

  Calendario copyWith({
    String vigencia,
    List<CalendarioChild> items,
  }) {
    return Calendario(
      vigencia: vigencia ?? this.vigencia,
      items: items ?? this.items,
    );
  }
}
