import 'package:el_meu_diec/model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Gender', () {
    group('.toString()', () {
      test('should return a string representation of this Gender', () {
        expect(Gender.f.toString(), 'f.');
        expect(Gender.m.toString(), 'm.');
      });
    });
  });
}
