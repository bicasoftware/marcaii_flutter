import 'package:flutter/material.dart';
import 'package:marcaii_flutter/helpers.dart';
import 'package:marcaii_flutter/strings.dart';

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
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 8, top: 8, bottom: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                      text: date.format(), style: const TextStyle(fontStyle: FontStyle.italic)),
                  const TextSpan(text: " - "),
                  const TextSpan(text: "${Strings.das} "),
                  TextSpan(
                    text: inicio,
                    style: TextStyle(fontStyle: FontStyle.italic, color: theme.accentColor),
                  ),
                  const TextSpan(text: " ${Strings.ate} "),
                  TextSpan(
                    text: termino,
                    style: TextStyle(fontStyle: FontStyle.italic, color: theme.accentColor),
                  )
                ],
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete_sweep, color: Colors.red),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }
}
