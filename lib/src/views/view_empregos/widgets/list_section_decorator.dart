import 'package:flutter/material.dart';

class ListSectionDecorator extends StatelessWidget {
  const ListSectionDecorator({
    @required this.label,
    this.padding = const EdgeInsets.all(16),
    Key key,
  }) : super(key: key);
  
  final String label;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: padding,
      width: double.maxFinite,
      child: Text(
        label,
        style: theme.textTheme.subtitle1.copyWith(color: theme.accentColor),
      ),
    );
  }
}
