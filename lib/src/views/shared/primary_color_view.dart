import 'package:flutter/material.dart';

class PrimaryColorView extends StatelessWidget {
  const PrimaryColorView({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
            colors: [
              Colors.deepOrange,
              Colors.red,
              Colors.deepOrange[900],
            ],
          ),
        ),
        width: double.maxFinite,
        child: child,
      ),
    );
  }
}
