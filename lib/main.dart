import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:marcaii_flutter/src/utils/token_manager.dart';
import 'package:marcaii_flutter/src/views/branch_view/branch_view.dart';
import 'package:marcaii_flutter/strings.dart';

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
      title: Strings.appName,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 2,
          brightness: Brightness.light,
          iconTheme: ThemeData.light().iconTheme,
          textTheme: ThemeData.light().textTheme.copyWith(
            title: const TextStyle(
              fontFamily: "Montserrat",
              fontSize: 20,
              color: Colors.black,
            )
          ),
          // textTheme: customTheme.textTheme,
        ),
        primarySwatch: Colors.deepOrange,
        primaryColor: Colors.deepOrange,
        accentColor: Colors.deepPurple,
        fontFamily: "Montserrat",
      ),
      home: BranchView(token: token),
    );
  }
}

ThemeData customTheme = ThemeData(
  appBarTheme: AppBarTheme(
    color: Colors.white,
    elevation: 2,
    brightness: Brightness.light,
    iconTheme: ThemeData.light().iconTheme,
  ),
  primarySwatch: Colors.deepOrange,
  primaryColor: Colors.deepOrange,
  accentColor: Colors.indigo,
  fontFamily: "Montserrat",
);
