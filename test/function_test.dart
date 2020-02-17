import 'package:flutter_test/flutter_test.dart';
import 'package:marcaii_flutter/src/views/shared/form_validation.dart';
import 'package:marcaii_flutter/helpers.dart';

void main() {
  test('test email', () {
    const email = "saulo@test.com";
    assert(validateEmail(email) == null);
  });

  test('test password', () {
    const password = "S17h05a8.";
    assert(validatePassword(password) == null);
  });

  test('weekday', () {
    final dt = DateTime(2020, 02, 16);
    assert(dt.indexWeekday() == 0);
  });
}
