import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:marcaii_flutter/src/database/dao/dao_empregos.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/views/view_branch/branch_view.dart';
import 'package:marcaii_flutter/src/views/view_empregos/view_empregos.dart';
import 'package:marcaii_flutter/strings.dart';

void main() => runApp(Marcaii());

class Marcaii extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      supportedLocales: const [Locale('pt', 'BR')],
      title: Strings.appName,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        primaryColor: Colors.deepOrange,
        accentColor: Colors.deepPurple,
        fontFamily: "Montserrat",
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 2,
          brightness: Brightness.light,
          iconTheme: ThemeData.light().iconTheme,
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: const TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.deepPurple,
          unselectedLabelColor: Colors.black45,
        ),
      ),
      routes: {
        Routes.routeEmpregos: (_) => ViewEmpregos(),
      },
      home: FutureObserver<List<Empregos>>(
        future: DaoEmpregos.fetchAll(),
        onSuccess: (_, empregos) => ViewBranch(empregos: empregos),
      ),
    );
  }
}

ThemeData customTheme = ThemeData(
  appBarTheme: AppBarTheme(
    color: Colors.white,
    elevation: 2,
    brightness: Brightness.light,
    iconTheme: ThemeData.light().iconTheme,
    textTheme: ThemeData.light().textTheme.copyWith(
          headline6: const TextStyle(
            fontFamily: "Montserrat",
            fontSize: 20,
            color: Colors.black,
          ),
        ),
    // textTheme: customTheme.textTheme,
  ),
  primarySwatch: Colors.deepOrange,
  primaryColor: Colors.deepOrange,
  accentColor: Colors.deepPurple,
  fontFamily: "Montserrat",
);
