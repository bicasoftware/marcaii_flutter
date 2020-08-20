import 'package:flutter/foundation.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:marcaii_flutter/src/utils/vault.dart';
import 'package:rxdart/rxdart.dart';

class BlocBrightness with BaseBloc {
  BlocBrightness({@required this.isDark}) {
    _inIsDark.add(isDark);
  }

  bool isDark;

  final BehaviorSubject<bool> _bhsIsDark = BehaviorSubject<bool>();
  Stream<bool> get outIsDark => _bhsIsDark.stream;
  Sink<bool> get _inIsDark => _bhsIsDark.sink;

  @override
  void dispose() {
    _bhsIsDark.close();
  }

  void toggleDark() {
    Vault.setIsDark(!isDark).then((_) => isDark = !isDark).whenComplete(() => _inIsDark.add(isDark));
  }
}
