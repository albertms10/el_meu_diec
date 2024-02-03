import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

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
    final response = await http.post(
      Uri.https(
        'dlc.iec.cat',
        '/Results/CompleteEntradaText',
        {
          'EntradaText': query,
          'OperEntrada': '${searchCondition.index}',
        },
      ),
      headers: const {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      debugPrint("Can't find definition");
      return null;
    }

    final responseBody = json.decode(response.body) as Map<String, dynamic>;

    return fromJson(responseBody['entrades'] as List<dynamic>);
  }
}
