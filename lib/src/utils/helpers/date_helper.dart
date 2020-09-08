import 'package:intl/intl.dart';

extension DateHelper on DateTime {
  String format({String pattern = 'dd/MM/yyyy'}) {
    return DateFormat(pattern).format(this);
  }

  String asString() => DateFormat('dd/MM/yyyy').format(this);
  int indexWeekday() {
    switch (weekday) {
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

  bool isSameDate(DateTime otherDate) {
    return year == otherDate.year && month == otherDate.month && day == otherDate.day;
  }

  String paddedWeekday(int padLen) => day.toString().padLeft(padLen, '0');
}
