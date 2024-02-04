import 'package:flutter/foundation.dart' show immutable;

import 'definition_entry_sense.dart';

@immutable
final class Word {
  final String id;
  final String word;
  final List<DefinitionEntrySense>? senses;

  const Word({required this.id, required this.word, required this.senses});
}
