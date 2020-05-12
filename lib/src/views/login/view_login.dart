import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/database/dao/dao_empregos.dart';
import 'package:marcaii_flutter/src/server/clients/user_client.dart';
import 'package:marcaii_flutter/src/server/models/user_data_dto.dart';
import 'package:marcaii_flutter/src/server/models/user_dto.dart';
import 'package:marcaii_flutter/src/utils/dialogs/dialogs.dart';
import 'package:marcaii_flutter/src/utils/token_manager.dart';
import 'package:marcaii_flutter/src/views/shared/form_validation.dart';
import 'package:marcaii_flutter/src/views/shared/link_button.dart';
import 'package:marcaii_flutter/src/views/shared/primary_color_view.dart';
import 'package:marcaii_flutter/src/views/shared/rounded_button.dart';
import 'package:marcaii_flutter/strings.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    @required this.setPosition,
    Key key,
  }) : super(key: key);
  final Function(int position) setPosition;

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController txtEmail, txtPass;
  final GlobalKey<State> _globalKey = GlobalKey<State>();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    txtEmail = TextEditingController(text: "");
    txtPass = TextEditingController(text: "");
    super.initState();
  }

  Future<void> _doLogin(BuildContext context) async {
    if (_formkey.currentState.validate()) {
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
          final vault = Vault();
          await vault.setAuthData(
            token: result.token,
            refreshToken: result.refresh_token,
            email: result.email,
          );
         await DaoEmpregos.syncFromServer(result.empregos);

          Navigator.of(_globalKey.currentContext, rootNavigator: true).pop();
          widget.setPosition(2);
        }
      } catch (e) {
        if (e is DioError) {
          Scaffold.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 10),
            content: Text(
              e.response.data[0]['message'],
              style: Theme.of(context).textTheme.caption.copyWith(color: Colors.red),
            ),
            elevation: 4,
            backgroundColor: Colors.white,
          ));
        } else {
          print(e);
        }

        Navigator.of(_globalKey.currentContext, rootNavigator: true).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PrimaryColorView(
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
            style: theme.textTheme.headline4.copyWith(
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
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: txtEmail,
                        autofocus: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Email",
                          hintText: "email@test.com",
                        ),
                        validator: validateEmail,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: txtPass,
                        autofocus: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Senha",
                          hintText: 'Digite a senha',
                        ),
                        obscureText: true,
                        validator: validatePassword,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          RoundedButton(
            padding: const EdgeInsets.all(8),
            label: "Entrar",
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              _doLogin(context);
            },
          ),
          LinkButton(
            label: "Cadastrar!",
            onPressed: () => widget.setPosition(1),
          ),
        ],
      ),
    );

    /* return Scaffold(
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
        
      ),
    ); */
  }
}
