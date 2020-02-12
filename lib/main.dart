import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:marcaii_flutter/src/views/branch_view/branch_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
          fontFamily: "Montserrat"),
      home: BranchView(),
    );
  }
}
