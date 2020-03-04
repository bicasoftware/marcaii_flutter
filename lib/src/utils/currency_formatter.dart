import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  CurrencyInputFormatter({this.maxDigits});
  final int maxDigits;

  static formatValue(double valor) {
    final f = NumberFormat("#,##0.00", "pt_BR");
    return "R\$ ${f.format(valor/100)}";
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if(newValue.selection.baseOffset == 0 ){
      return newValue;
    }

    if( maxDigits != null && newValue.selection.baseOffset > maxDigits) {
      return oldValue;
    }

    final valor = double.parse(newValue.text);
    final newText = formatValue(valor);
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
