import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TotaisInfoHeader extends StatelessWidget {
  const TotaisInfoHeader({
    @required this.porcentagem,
    @required this.title,
    @required this.color,
    Key key,
  }) : super(key: key);

  final int porcentagem;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 9,
            child: Text(
              title,
              style: theme.textTheme.bodyText1.copyWith(
                color: color,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "$porcentagem %",
              style: theme.textTheme.bodyText2,
              textAlign: TextAlign.end,
            ),
          )
        ],
      ),
    );
  }
}
