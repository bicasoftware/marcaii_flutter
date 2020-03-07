import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:marcaii_flutter/src/database/dao/dao_empregos.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_main.dart';
import 'package:marcaii_flutter/src/utils/token_manager.dart';
import 'package:marcaii_flutter/src/views/home_view/view_home.dart';
import 'package:marcaii_flutter/src/views/login/view_login.dart';
import 'package:marcaii_flutter/src/views/signin/view_signin.dart';
import 'package:marcaii_flutter/src/views/splash/splash_view.dart';
import 'package:provider/provider.dart';

class BranchView extends StatefulWidget {
  const BranchView({
    @required this.token,
    Key key,
  }) : super(key: key);

  final String token;

  @override
  _BranchViewState createState() => _BranchViewState();
}

class _BranchViewState extends State<BranchView> with SingleTickerProviderStateMixin {
  int position;
  TabController controller;

  Widget getActualView(int pos) {
    switch (pos) {
      case 0:
        return LoginView(setPosition: setPosition);
        break;
      case 1:
        return ViewSignin(setPosition: setPosition);
        break;
      case 2:
        return FutureObserver<List<Empregos>>(
          future: DaoEmpregos.fetchAll(),
          onSuccess: (_, List<Empregos> empregos) {
            return Provider<BlocMain>(
              create: (_) => BlocMain(
                token: widget.token,
                empregos: empregos,
              ),
              dispose: (_, BlocMain b) => b.dispose(),
              child: const ViewHome(),
            );
          },
        );
        break;
      default:
        return SplashView();
    }
  }

  @override
  void initState() {
    position = widget.token.isNotEmpty ? 2 : 0;
    controller = TabController(
      length: 3,
      vsync: this,
      initialIndex: position,
    );
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
      body: TabBarView(
        children: <Widget>[
          LoginView(setPosition: setPosition),
          ViewSignin(setPosition: setPosition),
          FutureObserver<List<Empregos>>(
            future: DaoEmpregos.fetchAll(),
            onSuccess: (_, List<Empregos> empregos) {
              return Provider<BlocMain>(
                create: (_) => BlocMain(
                  token: widget.token,
                  empregos: empregos,
                ),
                dispose: (_, BlocMain b) => b.dispose(),
                child: const ViewHome(),
              );
            },
          ),
        ],
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
      ),
      /* body: MorpheusTabView(
        child: getActualView(position),
      ), */
    );
  }
}
