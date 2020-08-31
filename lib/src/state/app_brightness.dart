import 'package:flutter/widgets.dart';

class AppBrightness extends ChangeNotifier {
  AppBrightness({this.isDark});

  bool isDark;

  void toggleBrightness() {
    isDark = !isDark;

    notifyListeners();
  }
}
