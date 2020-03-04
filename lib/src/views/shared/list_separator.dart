import 'package:flutter/material.dart';

class ListSeparator extends StatelessWidget {
  const ListSeparator({Key key, this.label}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Divider(),
          Text(
            label,
            style: theme.textTheme.subhead.copyWith(color: theme.accentColor),
          )
        ],
      ),
    );
  }
}
