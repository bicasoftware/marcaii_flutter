import 'package:marcaii_flutter/src/utils/double_utils.dart';
import 'package:marcaii_flutter/strings.dart';

class EmpregoValidate {
  static String validateSalario(String salario) {
    final s = currencyStringToDouble(salario);
    return s == 0 ? Validations.salarioRequerido : null;
  }
}
