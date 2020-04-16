import 'package:flutter/material.dart';

class ListSectionDecorator extends StatelessWidget {
  const ListSectionDecorator({
    @required this.label,
    Key key,
  }) : super(key: key);
  
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.maxFinite,
      child: Text(
        label,
        style: theme.textTheme.subhead.copyWith(color: theme.accentColor),
      ),
    );
  }
}
