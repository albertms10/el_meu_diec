import 'package:flutter/material.dart';

import 'word.dart';

/// The word cache.
class WordCache with ChangeNotifier {
  final Map<String, Word> _words;

  /// Creates a new [WordCache] from [_words].
  WordCache(this._words);

  /// Returns the [Word] from [id].
  Word? wordFromId(String id) => _words[id];

  /// Caches [Word] and returns `true` as a result.
  bool addWord(Word word) {
    _words.addAll({word.id: word});

    return true;
  }
}
