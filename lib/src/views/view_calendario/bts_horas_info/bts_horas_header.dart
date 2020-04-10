import 'package:flutter/material.dart';
import 'package:marcaii_flutter/helpers.dart';

class BtsHorasHeader extends StatelessWidget {
  const BtsHorasHeader({
    @required this.date,
    Key key,
  }) : super(key: key);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          flex: 6,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Text("Hora extra no Dia: ${date.format()}"),
          ),
        ),
        IconButton(
          icon: Icon(Icons.delete_sweep, color: Colors.red),
          onPressed: () => Navigator.of(context).pop(true),
        )
      ],
    );
  }
}
