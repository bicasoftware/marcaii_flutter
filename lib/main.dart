import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:marcaii_flutter/src/database/dao/dao_empregos.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/utils/vault.dart';
import 'package:marcaii_flutter/src/views/view_branch/branch_view.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:marcaii_flutter/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final List<Object> data = await Future.wait([
    DaoEmpregos.fetchAll(),
    Vault.getIsDark(),
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
  ]);

  runApp(
    Marcaii(
      empregos: data[0] as List<Empregos>,
      isDark: data[1] as bool,
    ),
  );
}

class Marcaii extends StatelessWidget {
  const Marcaii({Key key, this.empregos, this.isDark}) : super(key: key);
  final List<Empregos> empregos;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const [Locale('pt', 'BR')],
      title: Strings.appName,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      theme: isDark ? darkTheme() : lightTheme(),
      home: ViewBranch(empregos: empregos),
    );
  }
}
