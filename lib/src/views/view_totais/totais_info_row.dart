import 'package:flutter/material.dart';

class TotaisInfoRow extends StatelessWidget {
  const TotaisInfoRow({
    @required this.label,
    @required this.value,
    @required this.icon,
    Key key,
  }) : super(key: key);

  final String label, value;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: <Widget>[
        icon,
        const SizedBox(width: 16),
        Text(
          label,
          style: theme.textTheme.bodyText2.copyWith(
            fontStyle: FontStyle.italic,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: theme.textTheme.caption.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
