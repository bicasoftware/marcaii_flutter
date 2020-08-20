import 'package:flutter/material.dart';

extension ContextHelper on BuildContext {
  Future<T> navigate<T extends Object>(
    Widget route, {
    bool fullScreenDialog = true,
    Object arguments,
  }) async {
    return await Navigator.of(this).push(
      MaterialPageRoute<T>(
        builder: (_) => route,
        settings: RouteSettings(arguments: arguments),
      ),
    );
  }

  Future<void> goBack<T extends Object>([T result]) async {
    Navigator.of(this).pop<T>(result);
  }

  ThemeData get theme {
    return Theme.of(this);
  }

  TextTheme get textTheme {
    return theme.textTheme;
  }

  bool get isDarkMode {
    return theme.brightness == Brightness.dark;
  }
}
