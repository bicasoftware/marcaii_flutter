import 'package:flutter/material.dart';

class ListSeparator extends StatelessWidget {
  const ListSeparator({
    @required this.label,
    Key key,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
  }) : super(key: key);
  final String label;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: padding,
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
