import 'package:flutter/foundation.dart';

@immutable
class AutocompleteEntry {
  final String id;
  final String word;

  const AutocompleteEntry({required this.id, required this.word});

  AutocompleteEntry.fromJson(Map<String, dynamic> other)
      : id = other['id'] as String,
        word = other['word'] as String;
}
