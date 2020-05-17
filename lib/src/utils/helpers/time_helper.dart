import 'package:flutter/material.dart';

extension TimeHelper on TimeOfDay {
  String toShortString() {
    final h = hour.toString().padLeft(2, '0');
    final m = minute.toString().padLeft(2, '0');
    return "$h:$m";
  }

  bool isBefore(TimeOfDay otherTime) {
    final init = hour + minute;
    final end = otherTime.hour + otherTime.minute;

    return end - init < 0;
  }

  TimeOfDay addHour(int len) {
    final hora = hour + len;
    if (hora > 23) {
      throw Exception("Invalid hour");
    }

    return TimeOfDay(hour: hora, minute: minute);
  }
}

TimeOfDay stringToTimeOfDay(String time) {
  return TimeOfDay(
    hour: int.parse(time.substring(0, 2)),
    minute: int.parse(time.substring(3, 5)),
  );
}
