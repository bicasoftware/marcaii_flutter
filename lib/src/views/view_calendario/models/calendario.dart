import 'package:marcaii_flutter/src/views/view_calendario/models/calendario_child.dart';

class Calendario {
  Calendario({this.vigencia, this.items});

  final String vigencia;
  final List<CalendarioChild> items;

  void removeHora(int idhora) {
    items.firstWhere((CalendarioChild h) => h.hora?.id == idhora).reset();
  }
}
