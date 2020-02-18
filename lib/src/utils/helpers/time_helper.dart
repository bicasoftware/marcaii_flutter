import 'package:flutter/material.dart';

extension TimeHelper on TimeOfDay {
  String toShortString() {
    final h = this.hour.toString().padLeft(2, '0');
    final m = this.minute.toString().padLeft(2, '0');
    return "$h:$m";
  }
}

TimeOfDay stringToTimeOfDay(String time) {
  final times = time.split(":").map(int.parse).toList();
  return TimeOfDay(hour: times[0], minute: times[1]);
}
