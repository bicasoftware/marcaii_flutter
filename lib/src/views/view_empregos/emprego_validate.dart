import 'package:marcaii_flutter/src/utils/double_utils.dart';
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

  static String validateFechamento(String fechamento) {
    final dia = int.tryParse(fechamento);
    if (dia == null) {
      return Validations.fechamentoRequerido;
    } else if (dia > 30 || dia < 1) {
      return Validations.fechamentoInvalido;
    } else {
      return null;
    }
  }

  static String validateSalario(String salario) {
    final s = currencyStringToDouble(salario);
    return s == 0 ? Validations.salarioRequerido : null;
  }
}
