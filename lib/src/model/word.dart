import 'definition_entry_sense.dart';

final class Word {
  final String id;
  final String word;
  final List<DefinitionEntrySense>? senses;

  Word({required this.id, required this.word, required this.senses});
}
