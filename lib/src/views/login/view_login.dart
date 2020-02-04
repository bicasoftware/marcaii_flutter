import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/server/clients/user_client.dart';
import 'package:marcaii_flutter/src/server/models/user_data_dto.dart';
import 'package:marcaii_flutter/src/server/models/user_dto.dart';
import 'package:marcaii_flutter/src/utils/token_manager.dart';
import 'package:marcaii_flutter/src/views/dialogs/dialogs.dart';
import 'package:marcaii_flutter/src/views/shared/rounded_button.dart';
import 'package:marcaii_flutter/src/views/signin/view_signin.dart';
import 'package:marcaii_flutter/src/views/splash/splash_view.dart';
import 'package:marcaii_flutter/strings.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController txtEmail, txtPass;
  final GlobalKey<State> _globalKey = GlobalKey<State>();

  @override
  void initState() {
    txtEmail = TextEditingController(text: "");
    txtPass = TextEditingController(text: "***");
    super.initState();
  }

  Future<void> _doLogin(BuildContext context) async {
    // ignore: unawaited_futures
    showAwaitingDialog(context: context, key: _globalKey);

    try {
      final dio = Dio();
      final auth = UserClient(dio);
      final result = await auth.authenticate(
        UserDto(
          email: txtEmail.text,
          password: txtPass.text,
        ),
      );

      if (result is UserDataDto) {
        final tokenManager = TokenManager();
        await tokenManager.setAuthData(
          token: result.token,
          refreshToken: result.refresh_token,
        );
        Navigator.of(_globalKey.currentContext, rootNavigator: true).pop();
        await Navigator.of(context).pushReplacement(
          MaterialPageRoute(fullscreenDialog: false, builder: (_) => SplashView()),
        );
      }
    } catch (e) {
      if (e is DioError) {
        print(e);
      }

      Navigator.of(_globalKey.currentContext, rootNavigator: true).pop();
    }
  }

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
        child: ListView(
          shrinkWrap: false,
          children: <Widget>[
            const SizedBox(height: 32),
            Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.fitHeight,
              height: 120,
            ),
            Text(
              Strings.appName,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: theme.textTheme.display1.copyWith(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 36),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                margin: const EdgeInsets.all(0),
                elevation: 2,
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: txtEmail,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Email",
                          hintText: "email@test.com",
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: txtPass,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Senha",
                          hintText: 'Digite a senha',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RoundedButton(
                label: "Entrar",
                onPressed: () => _doLogin(context),
              ),
            ),
            FlatButton(
              splashColor: Colors.white54,
              child: Text(
                "Cadastrar!",
                style: theme.textTheme.caption
                    .copyWith(color: Colors.white70, decoration: TextDecoration.underline),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ViewSignin(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
