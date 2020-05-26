import 'package:flutter_test/flutter_test.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';

void main() {
  group('vigencia tests', () {
    test('vigencia.dateRange', () {
      final v = Vigencia.fromString("02/2020");
      print(v.getDateRange(25));
    });

    test('equals', () {
      final v1 = Vigencia(ano: 2010, mes: 1);
      final v2 = Vigencia(ano: 2010, mes: 1);

      assert(v1.compare(v2));
    });
  });
}
