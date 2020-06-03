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
    return ListTile(
      dense: true,
      leading: icon,
      title: Text(label),
      trailing: Text(
        value,
        style: theme.textTheme.caption.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
