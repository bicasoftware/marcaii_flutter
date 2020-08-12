import 'package:flutter/material.dart';

class LightContainer extends StatelessWidget {
  const LightContainer({
    @required this.child,
    this.padding,
    this.margin,
    Key key,
  }) : super(key: key);
  final Widget child;
  final EdgeInsets padding, margin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      child: child,
      padding: padding ?? const EdgeInsets.all(8),
      margin: margin ?? const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        color: theme.cardColor,
        border: Border.all(
          color: theme.dividerColor,
          width: .6,
        ),
      ),
    );
  }
}
