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
        Divider(color: color, indent: 16, endIndent: 16, height: 0,thickness: .5),
      ],
    );

    /* return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 9,
            child: Text(
              title,
              style: theme.textTheme.bodyText1.copyWith(
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "$porcentagem %",
              style: theme.textTheme.button.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.end,
            ),
          )
        ],
      ),
    ); */
  }
}
