import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/utils/token_manager.dart';
import 'package:marcaii_flutter/src/views/home_view/view_home.dart';
import 'package:marcaii_flutter/src/views/login/view_login.dart';
import 'package:marcaii_flutter/src/views/signin/view_signin.dart';
import 'package:marcaii_flutter/src/views/splash/splash_view.dart';
import 'package:morpheus/morpheus.dart';

class BranchView extends StatefulWidget {
  const BranchView({Key key, this.token}) : super(key: key);
  final String token;

  @override
  _BranchViewState createState() => _BranchViewState();
}

class _BranchViewState extends State<BranchView> {
  int position;

  Widget getActualView(int pos) {
    switch (pos) {
      case 0:
        return LoginView(setPosition: setPosition);
        break;
      case 1:
        return ViewSignin(setPosition: setPosition);
        break;
      case 2:
        //TODO - adicionar isso dentro de um Provider
        //TODO - Criar MOBX!
        return const ViewHome();
        break;
      default:
        return SplashView();
    }
  }

  @override
  void initState() {
    position = widget.token.isNotEmpty ? 2 : 0;
    super.initState();
  }

  Future<String> findToken() async {
    final manager = TokenManager();
    return manager.getToken();
  }

  void setPosition(int pos) {
    setState(() => position = pos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MorpheusTabView(
        child: getActualView(position),
      ),
    );
  }
}
