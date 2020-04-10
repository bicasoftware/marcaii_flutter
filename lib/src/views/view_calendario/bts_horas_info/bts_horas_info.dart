import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/state/calendario_item.dart';
import 'package:marcaii_flutter/src/views/view_calendario/bts_horas_info/bts_horas_content.dart';
import 'package:marcaii_flutter/src/views/view_calendario/bts_horas_info/bts_horas_header.dart';

class BtsHorasInfo extends StatelessWidget {
  const BtsHorasInfo({
    Key key,
    this.calendarioChild,
    this.emprego,
    this.onDelete,
  }) : super(key: key);

  final void Function(CalendarioChild calendarioChild) onDelete;
  final CalendarioChild calendarioChild;
  final Empregos emprego;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            BtsHorasHeader(date: calendarioChild.date),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Divider(height: 8),
            ),
            BtsHorasContent(
              calendarChild: calendarioChild,
              emprego: emprego,
            ),
          ],
        ),
      ),
    );
  }
}
