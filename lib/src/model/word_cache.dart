import 'package:flutter/material.dart';

import 'word.dart';

/// The word cache.
class WordCache with ChangeNotifier {
  final Map<String, Word> _words;

  /// Creates a new [WordCache] from [_words].
  WordCache(this._words);

  /// Returns [Word] from [id], if cached.
  Word? wordFromId(String id) => _words[id];

  /// Adds [Word] to cache.
  void addWord(Word word) => _words.addAll({word.id: word});
}
