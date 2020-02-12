import 'package:flutter_test/flutter_test.dart';
import 'package:marcaii_flutter/src/views/shared/form_validation.dart';

void main() {
  test('testar', () {
    assert(1 == 1);
  });

  test('test email', () {
    const email = "saulo@test.com";
    assert(validateEmail(email) == null);
  });

  test('test password', () {
    const password = "S17h05a8.";
    assert(validatePassword(password) == null);
  });
}
