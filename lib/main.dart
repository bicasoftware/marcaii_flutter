import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:marcaii_flutter/src/utils/token_manager.dart';
import 'package:marcaii_flutter/src/views/branch_view/branch_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final manager = TokenManager();
  final token = await manager.getToken();

  runApp(Marcaii(token: token));
}

class Marcaii extends StatelessWidget {
  const Marcaii({Key key, this.token}) : super(key: key);
  final String token;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        primaryColor: Colors.deepOrange,
        accentColor: Colors.teal,
        fontFamily: "Montserrat",
      ),
      home: BranchView(token: token),
    );
  }
}
