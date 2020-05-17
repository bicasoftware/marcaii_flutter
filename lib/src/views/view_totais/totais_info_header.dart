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
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                title,
                style: theme.textTheme.bodyText1.copyWith(
                  color: color,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const Spacer(),
              if (porcentagem != null)
                Text(
                  "$porcentagem %",
                  style: theme.textTheme.button.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.end,
                )
            ],
          ),
        ),
        Divider(color: color, indent: 16, endIndent: 16, height: 0, thickness: .5),
      ],
    );
  }
}
