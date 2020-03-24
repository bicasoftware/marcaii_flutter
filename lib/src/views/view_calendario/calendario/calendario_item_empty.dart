import 'package:flutter/material.dart';
import 'package:marcaii_flutter/helpers.dart';

class CalendarioEmptyCells {
  static Widget _emptyContainer() {
    return AspectRatio(
      aspectRatio: 1.1,
      child: Container(),
    );
  }

  static List<Widget> atBegin({@required DateTime initialDate}) {
    return <Widget>[
      for (int i = 0; i < initialDate.indexWeekday(); i++) _emptyContainer(),
    ];
  }

  static List<Widget> atEnd({@required DateTime lastDate}) {
    final endList = <Widget>[];
    var actualDate = lastDate;
    while(actualDate.weekday % 6 != 0) {
      endList.add(_emptyContainer());
      actualDate = actualDate.add(const Duration(days: 1));
    }

    return endList;
  }
}
