import 'package:flutter/material.dart';

ThemeData lightTheme() {
  return ThemeData(
    primarySwatch: Colors.lightBlue,
    primaryColor: Colors.lightBlue,
    accentColor: Colors.deepOrange,
    fontFamily: "Montserrat",
    cardColor: ThemeData.light().cardColor,
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
      labelColor: Colors.lightBlue,
      unselectedLabelColor: Colors.black45,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: 1,
      backgroundColor: Colors.deepOrange,
      splashColor: Colors.white,
      foregroundColor: Colors.white,
    ),
  );
}

ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.orange,
    primaryColor: Colors.orange,
    accentColor: Colors.lightBlue,
    fontFamily: "Montserrat",
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
    tabBarTheme: TabBarTheme(
      labelColor: Colors.lightBlue,
      unselectedLabelColor: Colors.black45,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: 1,
      backgroundColor: Colors.deepOrange,
      splashColor: Colors.white,
      foregroundColor: Colors.white,
    )
  );
}
