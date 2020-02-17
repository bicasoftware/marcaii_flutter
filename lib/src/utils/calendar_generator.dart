import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/state/calendario_item.dart';
import 'package:marcaii_flutter/helpers.dart';

class CalendarGenerator {
  static List<CalendarioChild> generate(int ano, int mes, List<Horas> horas) {
    var initDate = DateTime(ano, mes, 1);
    final items = <CalendarioChild>[];
    for (int i = 0; i < initDate.indexWeekday(); i++) {
      items.add(null);
    }
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

    for (int i = 0; i < 7 - initDate.indexWeekday(); i++) {
      items.add(null);
    }

    return items;
  }
}
