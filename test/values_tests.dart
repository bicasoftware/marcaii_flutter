import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  test('salario', () {
    final formatSalario = NumberFormat.simpleCurrency().format(3600.78);
    print(formatSalario);    
  });
}
