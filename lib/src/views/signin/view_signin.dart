import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/server/clients/user_client.dart';
import 'package:marcaii_flutter/src/server/models/user_dto.dart';
import 'package:marcaii_flutter/src/utils/token_manager.dart';
import 'package:marcaii_flutter/src/views/dialogs/dialogs.dart';
import 'package:marcaii_flutter/src/views/shared/primary_color_view.dart';
import 'package:marcaii_flutter/src/views/shared/rounded_button.dart';
import 'package:marcaii_flutter/src/views/splash/splash_view.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:marcaii_flutter/src/server/models/user_data_dto.dart';

class ViewSignin extends StatefulWidget {
  @override
  _ViewSigninState createState() => _ViewSigninState();
}

class _ViewSigninState extends State<ViewSignin> {
  TextEditingController txtEmail, txtPass, txtUsername;
  final GlobalKey<State> _globalKey = GlobalKey<State>();

  @override
  void initState() {
    txtEmail = TextEditingController();
    txtPass = TextEditingController();
    txtUsername = TextEditingController();
    super.initState();
  }

  Future _doSignin(BuildContext context) async {
    // ignore: unawaited_futures
    showAwaitingDialog(context: context, key: _globalKey);
    try {
      final dio = Dio();
      final client = UserClient(dio);
      final result = await client.register(
        UserDto(
          email: txtEmail.text,
          password: txtPass.text,
          username: txtUsername.text,
        ),
      );

      if (result is UserDataDto) {
        final manager = TokenManager();
        await manager.setAuthData(token: result.token, refreshToken: result.refresh_token);
        Navigator.of(_globalKey.currentContext, rootNavigator: true).pop();
        await Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            fullscreenDialog: false,
            builder: (_) => SplashView(),
          ),
        );
      }
    } catch (e) {
      if (e is DioError) {
        print(e.response.data);
      }
    }

    Navigator.of(_globalKey.currentContext, rootNavigator: true).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PrimaryColorView(
      child: ListView(
        shrinkWrap: false,
        children: <Widget>[
          const SizedBox(height: 16),
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
          const SizedBox(height: 16),
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
                      controller: txtUsername,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Apelido/Username",
                        hintText: 'user.user',
                      ),
                    ),
                    const SizedBox(height: 8),
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
              label: "Cadastrar!",
              onPressed: () => _doSignin(context),
            ),
          ),
        ],
      ),
    );
  }
}
