import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/utils/token_manager.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<String>(
          future: findToken(),
          initialData: "",
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Text(snapshot.data);
          },
        ),
      ),
      backgroundColor: Colors.deepOrange,
      body: Center(
        child: Card(
          elevation: 2,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
              Radius.circular(32),
            )),
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
