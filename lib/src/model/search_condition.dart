import 'package:diacritic/diacritic.dart';

enum SearchCondition {
  coincident,
  startingWith,
  endingIn,
  inAnyPosition,
  notStartingWith,
  notEndingIn,
  doesNotContain;

  static const defaultCondition = startingWith;

  /// Returns the highlighted range for [query] in [word] based on this
  /// [SearchCondition].
  ///
  /// Example:
  /// ```dart
  /// SearchCondition.startingWith.highlightedRange('dart', 'da')
  ///   == (0, 2)
  /// ```
  (int start, int end)? highlightedRange(String word, String query) {
    switch (this) {
      case coincident:
        return (0, word.length);

      case endingIn:
        var lastIndex = word.lastIndexOf(query);
        if (lastIndex == -1) {
          lastIndex =
              removeDiacritics(word).lastIndexOf(removeDiacritics(query));
        }
        if (lastIndex == -1) return null;
        return (lastIndex, lastIndex + query.length);

      case startingWith || inAnyPosition:
        var index = word.indexOf(query);
        if (index == -1) {
          index = removeDiacritics(word).indexOf(removeDiacritics(query));
        }
        if (index == -1) return null;
        return (index, index + query.length);

      default:
        return null;
    }
  }

  String translate() => switch (this) {
        coincident => 'Coincident',
        startingWith => 'Començada per',
        endingIn => 'Acabada en',
        inAnyPosition => 'En qualsevol posició',
        notStartingWith => 'No començada per',
        notEndingIn => 'No acabada en',
        doesNotContain => 'Que no contingui',
      };
}
