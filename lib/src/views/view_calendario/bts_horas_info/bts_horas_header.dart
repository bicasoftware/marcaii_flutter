import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marcaii_flutter/src/views/widgets/hora_info_header.dart';

class BtsHorasHeader extends StatelessWidget {
  const BtsHorasHeader({
    @required this.date,
    @required this.inicio,
    @required this.termino,
    Key key,
  }) : super(key: key);

  final DateTime date;
  final String inicio, termino;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 8, top: 8, bottom: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: HoraHeaderText(date: date, inicio: inicio, termino: termino),
          ),
          IconButton(
            icon: const Icon(Icons.delete_sweep, color: Colors.red),
            onPressed: () => Get.back(result: true),
          ),
        ],
      ),
    );
  }
}
