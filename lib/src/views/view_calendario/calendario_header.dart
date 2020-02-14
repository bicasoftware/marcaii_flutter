import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/views/view_calendario/calendario_header_item.dart';
import 'package:marcaii_flutter/strings.dart';

class CalendarioHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepOrange,
      padding: const EdgeInsets.all(4),
      child: Row(children: [
        for (final d in Consts.weekDay)
          Expanded(
            child: CalendarioHeaderItem(weekDay: d),
          )
      ]),
    );
  }
}
