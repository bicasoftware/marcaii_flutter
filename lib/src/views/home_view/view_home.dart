import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/views/splash/splash_view.dart';

class ViewHome extends StatelessWidget {
  const ViewHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Container(
        width: double.maxFinite,
        color: Colors.amber,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            MaterialButton(
              color: Colors.white,
              child: const Text("Clicar"),
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(fullscreenDialog: true, builder: (_) => SplashView()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
