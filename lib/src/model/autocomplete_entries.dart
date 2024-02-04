import '../repositories/diec_repository.dart';
import 'autocomplete_entry.dart';
import 'search_condition.dart';

extension AutocompleteEntries on List<AutocompleteEntry> {
  static List<AutocompleteEntry> fromJson(List<dynamic> others) => [
        for (final entry in others)
          AutocompleteEntry.fromJson(entry as Map<String, dynamic>),
      ];

  static Future<List<AutocompleteEntry>?> fetch(
    String query, {
    SearchCondition searchCondition = SearchCondition.defaultCondition,
  }) async {
    final responseBody = await const DIECRepository()
        .autocompleteEntries(query, searchCondition: searchCondition);

    return fromJson(responseBody['entrades'] as List<dynamic>);
  }
}
