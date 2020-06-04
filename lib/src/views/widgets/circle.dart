import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  const Circle({
    @required this.color,
    this.size = 30,
    Key key,
  }) : super(key: key);

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: size,
        width: size,
      ),
    );
  }
}
