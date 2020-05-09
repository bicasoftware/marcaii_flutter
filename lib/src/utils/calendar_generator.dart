import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/state/calendario_child.dart';
import 'package:marcaii_flutter/helpers.dart';

class CalendarGenerator {
  static List<CalendarioChild> generate(int ano, int mes, List<Horas> horas) {
    var initDate = DateTime(ano, mes, 1);
    final items = <CalendarioChild>[];

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
