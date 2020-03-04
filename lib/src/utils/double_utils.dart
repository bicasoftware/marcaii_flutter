import 'package:intl/intl.dart';

double currencyStringToDouble(String cs) {
  final onlyDigits = int.parse(cs.replaceAll(RegExp('[^0-9]'), ""));

  return onlyDigits / 100;
}

String doubleToCurrency(double valor) {
  final f = NumberFormat("#,##0.00", "pt_BR");
  return "R\$ ${f.format(valor)}";
}
