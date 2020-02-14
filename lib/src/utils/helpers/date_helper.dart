import 'package:intl/intl.dart';

extension DateHelper on DateTime {
  String asString() => DateFormat("dd/MM/yyyy").format(this);
  String asStringWithPattern(String pattern) => DateFormat(pattern).format(this);
  int indexWeekday() {
    switch (this.weekday) {
      case DateTime.sunday:
        return 0;
        break;
      case DateTime.monday:
        return 1;
        break;
      case DateTime.tuesday:
        return 2;
        break;
      case DateTime.wednesday:
        return 3;
        break;
      case DateTime.thursday:
        return 4;
        break;
      case DateTime.friday:
        return 5;
        break;
      case DateTime.saturday:
        return 6;
        break;
      default:
        return null;
        break;
    }
  }

  String paddedWeekday(int padLen) => this.day.toString().padLeft(padLen, "0");
}
