import 'package:el_meu_diec/model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SearchCondition', () {
    group('.highlightedRange()', () {
      test('should return the highlighted range in word from query', () {
        expect(
          SearchCondition.coincident.highlightedRange('dart', 'a'),
          const (0, 4),
        );

        expect(
          SearchCondition.startingWith.highlightedRange('dart', 'd'),
          const (0, 1),
        );
        expect(
          SearchCondition.startingWith.highlightedRange('fabària', 'faba'),
          const (0, 4),
        );

        expect(
          SearchCondition.endingIn.highlightedRange('dart', 'rt'),
          const (2, 4),
        );
        expect(
          SearchCondition.endingIn.highlightedRange('dart2', 't'),
          const (3, 4),
        );
        expect(
          SearchCondition.endingIn.highlightedRange('fabària', 'aria'),
          const (3, 7),
        );

        expect(
          SearchCondition.inAnyPosition.highlightedRange('dart', 'a'),
          const (1, 2),
        );
      });

      test('should return null when no range to highlight is found', () {
        expect(
          SearchCondition.startingWith.highlightedRange('dart', 'c'),
          isNull,
        );
        expect(
          SearchCondition.notStartingWith.highlightedRange('dart', 'f'),
          isNull,
        );
        expect(
          SearchCondition.notEndingIn.highlightedRange('dart', 'f'),
          isNull,
        );
        expect(
          SearchCondition.doesNotContain.highlightedRange('dart', 'f'),
          isNull,
        );
      });
    });
  });
}
