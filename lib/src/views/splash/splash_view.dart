import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/views/shared/primary_color_view.dart';

class SplashView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return PrimaryColorView(
      child: Center(
        child: Card(
          elevation: 2,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(32),
              ),
            ),
            child: Image.asset(
              'assets/images/logo.png',
              alignment: Alignment.center,
              fit: BoxFit.fitWidth,
              width: 300,
            ),
          ),
        ),
      ),
    );
  }
}
