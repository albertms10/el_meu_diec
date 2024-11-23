import 'dart:convert' show json;

import 'package:flutter/foundation.dart' show debugPrint, immutable;
import 'package:http/http.dart' as http;

import '../model/search_condition.dart';
import 'repository.dart';

@immutable
final class DIECRepository extends DictionaryRepository {
  const DIECRepository({super.authority = 'dlc.iec.cat'});

  @override
  Future<Map<String, dynamic>> autocompleteEntries(
    String query, {
    required SearchCondition searchCondition,
  }) async {
    final response = await http.post(
      Uri.https(
        authority,
        '/Results/CompleteEntradaText',
        {
          'EntradaText': query,
          'OperEntrada': '${searchCondition.index}',
        },
      ),
      headers: const {'Content-Type': 'application/json'},
    );

    return _parseResponse(response);
  }

  @override
  Future<Map<String, dynamic>> definitionEntries(String id) async {
    final response = await http.post(
      Uri.https(authority, '/Results/Accepcio', {'id': id}),
      headers: const {'Content-Type': 'application/json'},
    );

    return _parseResponse(response);
  }

  Map<String, dynamic> _parseResponse(http.Response response) {
    if (response.statusCode != 200) {
      debugPrint("Can't find definition");
    }

    return json.decode(response.body) as Map<String, dynamic>;
  }
}
