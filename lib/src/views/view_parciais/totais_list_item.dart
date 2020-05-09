import 'package:flutter/material.dart';
import 'package:marcaii_flutter/helpers.dart';
import 'package:marcaii_flutter/src/utils/double_utils.dart';
import 'package:marcaii_flutter/src/views/view_parciais/totais_info_row.dart';
import 'package:marcaii_flutter/strings.dart';

class TotaisListItem extends StatelessWidget {
  const TotaisListItem({
    @required this.minutes,
    @required this.data,
    @required this.color,
    Key key,
  }) : super(key: key);

  final int minutes;
  final DateTime data;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: <Widget>[
        Icon(Icons.date_range, color: color),
        const SizedBox(width: 16),
        Text(
          data.asString(),
          style: theme.textTheme.bodyText1.copyWith(),
        ),
        const Spacer(),
        Text(
          "$minutes ${Strings.minutos}",
          style: theme.textTheme.caption.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.accentColor,
          ),
        ),
      ],
    );
  }
}
