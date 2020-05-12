import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:marcaii_flutter/helpers.dart';
import 'package:marcaii_flutter/strings.dart';

class TotaisListItem extends StatelessWidget {
  const TotaisListItem({
    @required this.minutes,
    @required this.data,
    Key key,
  }) : super(key: key);

  final int minutes;
  final DateTime data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: <Widget>[
        Icon(LineAwesomeIcons.calendar, color: Colors.grey[500]),
        const SizedBox(width: 16),
        Text(
          data.asString(),
          style: theme.textTheme.bodyText1.copyWith(fontWeight: FontWeight.normal),
        ),
        const Spacer(),
        Text(
          "$minutes ${Strings.minutos}",
          style: theme.textTheme.caption.copyWith(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
