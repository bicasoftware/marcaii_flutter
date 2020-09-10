import 'package:flutter/material.dart';

FloatingActionButtonThemeData fabTheme = const FloatingActionButtonThemeData(
  elevation: 1,
  backgroundColor: Colors.deepOrange,
  splashColor: Colors.white,
  foregroundColor: Colors.white,
);

ThemeData _baseTheme = ThemeData(
  primarySwatch: Colors.deepOrange,
  primaryColor: Colors.deepOrange,
  accentColor: Colors.lightBlue,
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
  floatingActionButtonTheme: fabTheme,
);

ThemeData lightTheme() {
  return _baseTheme.copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    highlightColor: Colors.green[100],
    cardColor: ThemeData.light().cardColor,
    canvasColor: ThemeData.light().canvasColor,
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
  );  
}

ThemeData darkTheme() {
  return ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.dark,
    primarySwatch: Colors.deepOrange,
    primaryColor: Colors.deepOrange,
    accentColor: Colors.lightBlue,
    fontFamily: "Montserrat",
    highlightColor: Colors.blueGrey,
    cardColor: ThemeData.dark().cardColor,
    canvasColor: ThemeData.dark().canvasColor,
    appBarTheme: AppBarTheme(
      color: ThemeData.dark().cardColor,
      elevation: 2,
      brightness: Brightness.dark,
      iconTheme: ThemeData.dark().iconTheme,
      textTheme: ThemeData.dark().textTheme.copyWith(
            headline6: const TextStyle(
              fontFamily: "Montserrat",
              fontSize: 20,
              color: Colors.white,
            ),
          ),
    ),
    floatingActionButtonTheme: fabTheme,
  );
}
