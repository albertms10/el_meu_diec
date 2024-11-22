import '../model/search_condition.dart';

abstract class DictionaryRepository {
  final String authority;

  const DictionaryRepository({required this.authority});

  Future<Map<String, dynamic>> autocompleteEntries(
    String query, {
    required SearchCondition searchCondition,
  });

  Future<Map<String, dynamic>> definitionEntries(String id);
}
