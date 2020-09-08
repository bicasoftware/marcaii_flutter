import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/utils/helpers/date_helper.dart';
import 'package:marcaii_flutter/strings.dart';

class HoraHeaderText extends StatelessWidget {
  const HoraHeaderText({
    @required this.date,
    @required this.inicio,
    @required this.termino,
    Key key,
  }) : super(key: key);

  final DateTime date;
  final String inicio;
  final String termino;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RichText(
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
    );
  }
}