import 'package:flutter/foundation.dart';

import 'definition_entry_sense.dart';
import 'word.dart';

@immutable
final class AutocompleteEntry {
  final String id;
  final String word;

  const AutocompleteEntry({required this.id, required this.word});

  AutocompleteEntry.fromJson(Map<String, dynamic> other)
      : id = other['id'] as String,
        word = other['word'] as String;

  Word toWord({List<DefinitionEntrySense>? senses}) => Word(
        id: id,
        word: word,
        senses: senses,
      );
}
