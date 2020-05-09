import 'package:flutter/material.dart';

class BottomIndicatorContainer extends StatelessWidget {
  const BottomIndicatorContainer({
    @required this.child,
    this.indicatorColor,
    this.indicatorThickness = 8,
    this.radius = 8,
    this.elevation = 1,
    Key key,
  }) : super(key: key);

  final Widget child;
  final Color indicatorColor;
  final double indicatorThickness, radius, elevation;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      elevation: elevation,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: indicatorColor ?? Theme.of(context).accentColor,
                  width: indicatorThickness),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
