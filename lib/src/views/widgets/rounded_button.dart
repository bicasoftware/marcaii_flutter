import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    @required this.label,
    @required this.onPressed,
    this.padding = const EdgeInsets.all(8),
    this.extend = true,
    this.color = Colors.white,
    Key key,
  }) : super(key: key);

  final bool extend;
  final Color color;
  final String label;
  final VoidCallback onPressed;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: MaterialButton(
        minWidth: extend ? double.maxFinite : double.maxFinite,
        color: color,
        child: Text(label),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(64),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
