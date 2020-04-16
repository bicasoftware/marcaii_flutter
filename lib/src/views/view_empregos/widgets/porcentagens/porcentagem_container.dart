import 'package:flutter/material.dart';

class PorcentagemContainer extends StatelessWidget {
  const PorcentagemContainer({
    @required this.porc,
    @required this.onTap,
    @required this.label,
    @required this.iconColor,
    Key key,
  }) : super(key: key);

  final int porc;
  final String label;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: <Widget>[
            Icon(
              Icons.info,
              color: iconColor,
            ),
            const SizedBox(width: 16),
            Column(
              children: <Widget>[
                Text(label, style: theme.textTheme.subtitle),
                const SizedBox(height: 8),
                Text("$porc %", style: theme.textTheme.subhead),
              ],
            ),
          ],
        ),
      ),
    );
  }
}