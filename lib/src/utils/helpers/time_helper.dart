import 'package:flutter/material.dart';

extension TimeHelper on TimeOfDay {
  String toShortString() {
    final h = this.hour.toString().padLeft(2, '0');
    final m = this.minute.toString().padLeft(2, '0');
    return "$h:$m";
  }

  bool isBefore(TimeOfDay otherTime) {
    final init = this.hour + this.minute;
    final end = otherTime.hour + otherTime.minute;

    return end - init < 0;
  }
}

TimeOfDay stringToTimeOfDay(String time) {
  final times = time.split(":").map(int.parse).toList();
  return TimeOfDay(hour: times[0], minute: times[1]);
}
