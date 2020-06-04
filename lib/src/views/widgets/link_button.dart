import 'package:flutter/material.dart';

class LinkButton extends StatelessWidget {
  const LinkButton({
    Key key,
    this.label,
    this.onPressed,
  }) : super(key: key);

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FlatButton(
      splashColor: Colors.white54,
      child: Text(
        label,
        style: theme.textTheme.caption.copyWith(
          color: Colors.white70,
          decoration: TextDecoration.underline,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
