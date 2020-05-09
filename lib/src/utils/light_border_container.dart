import 'package:flutter/material.dart';

class LightBorderContainer extends StatelessWidget {
  const LightBorderContainer({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).dividerColor;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        border: Border(
          bottom: BorderSide(color: color),
          top: BorderSide(color: color),
          right: BorderSide(color: color),
          left: BorderSide(color: color),
        ),
      ),
      child: child,
    );
  }
}
