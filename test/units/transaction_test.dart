import 'package:bytebank_persistencia/models/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should return the value when create a transaction', () {
    final Transaction transacrion = Transaction(null, 200, null);
    expect(transacrion.value, 200);
  });
  
  test('should show an error if create transaction with value less then one', () {
    expect(() => Transaction(null, 2, null), throwsAssertionError);
  });
}