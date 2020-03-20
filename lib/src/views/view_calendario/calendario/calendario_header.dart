import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/views/view_calendario/calendario/calendario_header_item.dart';
import 'package:marcaii_flutter/strings.dart';

class CalendarioHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Row(children: [
        for (final d in Consts.weekDayShort)
          Expanded(
            child: CalendarioHeaderItem(weekDay: d),
          )
      ]),
    );
  }
}
