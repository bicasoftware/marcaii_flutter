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

  Calendario removeHora(int idhora) {
    final int index = items.indexWhere((h) => h.hora?.id == idhora);
    final _items = [...items];
    _items.replaceRange(
      index,
      index + 1,
      <CalendarioChild>[CalendarioChild(hora: null, date: items[index].date)],
    );

    return Calendario(vigencia: this.vigencia, items: _items);
  }
}
