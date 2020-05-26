import 'package:marcaii_flutter/src/state/calendario/calendario_child.dart';

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

  void removeHora(int idhora) {
    items.firstWhere((CalendarioChild h) => h.hora?.id == idhora).reset();
  }
}