import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_utils/async_widgets/async_widget.dart';
import 'package:get/get.dart';
import 'package:marcaii_flutter/src/database/dao/dao_empregos.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/utils/vault.dart';
import 'package:marcaii_flutter/src/views/view_branch/branch_view.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:marcaii_flutter/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isDark = await Vault.getIsDark();
  runApp(Marcaii(isDark: isDark));
}

class Marcaii extends StatelessWidget {
  const Marcaii({Key key, this.isDark}) : super(key: key);
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(            
      defaultTransition: Transition.topLevel,
      supportedLocales: const [Locale('pt', 'BR')],
      title: Strings.appName,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      theme: isDark ? darkTheme() : lightTheme(),
      home: FutureObserver<List<Empregos>>(
        future: DaoEmpregos.fetchAll(),
        onSuccess: (BuildContext context, List<Empregos> empregos) {
          return ViewBranch(empregos: empregos);
        },
      ),
    );
  }
}
