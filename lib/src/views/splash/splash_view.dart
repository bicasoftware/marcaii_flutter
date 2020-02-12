import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/utils/token_manager.dart';
import 'package:marcaii_flutter/src/views/shared/primary_color_view.dart';

//TODO - criar rotina que cheque token e banco de dados
//e que vá mostre a tela principal, login ou Splash

class SplashView extends StatelessWidget {
  Future<String> findToken() async {
    final manager = TokenManager();
    return manager.getToken();
  }

  Future<String> findRefreshToken() async {
    final manager = TokenManager();
    return manager.getRefreshToken();
  }

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
