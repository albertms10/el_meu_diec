import 'package:flutter/foundation.dart' show immutable, listEquals;

import 'definition_entry_sense.dart';

@immutable
final class Word {
  final String id;
  final String word;
  final List<DefinitionEntrySense>? senses;

  const Word({required this.id, required this.word, this.senses});

  @override
  String toString() => 'Word($id: $word)';

  @override
  bool operator ==(Object other) =>
      other is Word &&
      id == other.id &&
      word == other.word &&
      listEquals(senses, other.senses);

  @override
  int get hashCode => Object.hash(
        id,
        word,
        senses != null ? Object.hashAll(senses!) : null,
      );
}
