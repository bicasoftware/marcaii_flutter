import 'package:flutter_test/flutter_test.dart';
import 'package:marcaii_flutter/helpers.dart';

void main() {
  test('test self', () {
    assert(true == true);
  });

  test('is same date', () {
    final dt = DateTime(2020, 01, 01, 18, 0);
    final dt2 = DateTime(2020, 01, 01, 19, 0);
    assert(dt.isSameDate(dt2));
  });
}
