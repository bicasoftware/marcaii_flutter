import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    @required this.label,
    @required this.onPressed,
    this.extend = true,
    this.color = Colors.white,
    Key key,
  }) : super(key: key);

  final bool extend;
  final Color color;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: extend ? double.maxFinite : double.maxFinite,
      color: color,
      child: Text(label),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(64),
      ),
      onPressed: onPressed,
    );
  }
}
