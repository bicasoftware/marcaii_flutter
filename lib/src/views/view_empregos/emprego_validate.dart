import 'package:marcaii_flutter/strings.dart';

class EmpregoValidate {
  static String validatePorc(String porc, int min) {
    final p = int.tryParse(porc);

    if (p == null) {
      return Validations.porcentagemRequerida;
    } else if (p < 30) {
      return Validations.porcentagemInvalida;
    } else {
      return null;
    }
  }
}
