import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:marcaii_flutter/src/database/dao/dao_empregos.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/state/notifiers/app_brightness.dart';
import 'package:marcaii_flutter/src/utils/vault.dart';
import 'package:marcaii_flutter/src/views/view_branch/branch_view.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:marcaii_flutter/themes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final empregos = await DaoEmpregos.fetchAll();
  final isDark = await Vault.getIsDark();

  runApp(
    Marcaii(
      empregos: empregos,
      isDark: isDark,
    ),
  );
}

class Marcaii extends StatelessWidget {
  const Marcaii({Key key, this.empregos, this.isDark}) : super(key: key);
  final List<Empregos> empregos;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppBrightness>(
      create: (_) => AppBrightness(isDark: isDark),
      child: Consumer<AppBrightness>(
        builder: (_, brighness, w) => MaterialApp(
          supportedLocales: const [Locale('pt', 'BR')],
          title: Strings.appName,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          theme: brighness.isDark ? darkTheme() : lightTheme(),
          home: ViewBranch(empregos: empregos),
        ),
      ),
    );
  }
}
