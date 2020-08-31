import 'package:flutter/foundation.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/state/calendario/calendario_child.dart';
import 'package:marcaii_flutter/helpers.dart';

class CalendarGenerator {
  static List<CalendarioChild> generate({
    @required int ano,
    @required int mes,
    @required List<Horas> horas,
  }) {
    var initDate = DateTime(ano, mes, 1);
    final items = <CalendarioChild>[];
    print("Total horas: ${horas.length}");

    print("dateMonth: ${initDate.month}, mes: $mes");
    while (initDate.month == mes) {
      items.add(
        CalendarioChild(
          date: initDate,
          hora: horas.firstWhere(
            (h) => h.data.isSameDate(initDate),
            orElse: () => null,
          ),
        ),
      );

      initDate = initDate.add(const Duration(days: 1));
    }

    return items;
  }
}
