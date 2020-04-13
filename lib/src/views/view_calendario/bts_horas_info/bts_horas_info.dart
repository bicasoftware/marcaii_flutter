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
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          BtsHorasHeader(
            date: calendarioChild.date,
            inicio: calendarioChild.hora.inicio,
            termino: calendarioChild.hora.termino,
          ),
          const Divider(height: 0, endIndent: 16, indent: 16),
          BtsHorasContent(
            calendarChild: calendarioChild,
            emprego: emprego,
          ),
        ],
      ),
    );
  }
}
