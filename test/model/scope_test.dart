import 'package:el_meu_diec/model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Scope', () {
    group('.toString()', () {
      test('should return a string representation of this Scope', () {
        expect(Scope.AGF.toString(), '[AGF]');
        expect(Scope.ENG.toString(), '[ENG]');
        expect(Scope.TC.toString(), '[TC]');
      });
    });
  });
}
