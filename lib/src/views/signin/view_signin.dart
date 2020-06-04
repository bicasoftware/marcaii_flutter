import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/server/clients/user_client.dart';
import 'package:marcaii_flutter/src/server/models/user_data_dto.dart';
import 'package:marcaii_flutter/src/server/models/user_dto.dart';
import 'package:marcaii_flutter/src/utils/vault.dart';
import 'package:marcaii_flutter/src/views/widgets/dialogs.dart';
import 'package:marcaii_flutter/src/views/widgets/form_validation.dart';
import 'package:marcaii_flutter/src/views/widgets/link_button.dart';
import 'package:marcaii_flutter/src/views/widgets/primary_color_view.dart';
import 'package:marcaii_flutter/src/views/widgets/rounded_button.dart';
import 'package:marcaii_flutter/strings.dart';

class ViewSignin extends StatefulWidget {
  const ViewSignin({
    @required this.setPosition,
    Key key,
  }) : super(key: key);

  final Function(int position) setPosition;

  @override
  _ViewSigninState createState() => _ViewSigninState();
}

class _ViewSigninState extends State<ViewSignin> {
  TextEditingController txtEmail, txtPass, txtUsername;
  String emailError;
  final _globalKey = GlobalKey<State>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    txtEmail = TextEditingController();
    txtPass = TextEditingController();
    txtUsername = TextEditingController();
    emailError = "";
    super.initState();
  }

  Future _doSignin(BuildContext context) async {
    if (_formKey.currentState.validate()) {
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
          final vault = Vault();
          await vault.setAuthData(
            token: result.token,
            refreshToken: result.refresh_token,
            email: result.email,
          );
          Navigator.of(_globalKey.currentContext, rootNavigator: true).pop();
          widget.setPosition(2);
        }
      } catch (e) {
        if (e is DioError) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.white,
              content: Text(
                e.response.data[0]['message'],
                style: Theme.of(context).textTheme.caption.copyWith(color: Colors.red),
              ),
            ),
          );
        }
      }

      Navigator.of(_globalKey.currentContext, rootNavigator: true).pop();
    }
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
            style: theme.textTheme.headline4.copyWith(
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: txtUsername,
                        autofocus: false,
                        validator: validateUsername,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Apelido/Username",
                          hintText: 'user.user',
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        autofocus: false,
                        controller: txtEmail,
                        validator: validateEmail,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Email",
                          hintText: "email@test.com",
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        autofocus: false,
                        controller: txtPass,
                        validator: validatePassword,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Senha",
                          hintText: 'Digite a senha',
                        ),
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          RoundedButton(
            padding: const EdgeInsets.all(8),
            label: "Cadastrar!",
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              _doSignin(context);
            },
          ),
          LinkButton(
            label: "Voltar",
            onPressed: () => widget.setPosition(0),
          ),
        ],
      ),
    );
  }
}
