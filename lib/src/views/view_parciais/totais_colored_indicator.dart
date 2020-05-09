import 'package:flutter/material.dart';

class TotaisColoredIndicator extends StatelessWidget {
  const TotaisColoredIndicator({
    Key key,
    this.color,
    this.child,
  }) : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.center,
          colors: [color, Theme.of(context).canvasColor],
          stops: const [.6, 0],
        ),
      ),
      child: child,
    );
  }
}
