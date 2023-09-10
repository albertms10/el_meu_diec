// ignore_for_file: lines_longer_than_80_chars

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as html show parse;
import 'package:http/http.dart' as http;

import 'definition_entry_sense.dart';

extension DefinitionEntrySenses on List<DefinitionEntrySense> {
  static List<DefinitionEntrySense> fromElements(
    List<List<Element>> elements,
  ) =>
      [
        for (final element in elements)
          DefinitionEntrySense.fromElements(element),
      ];

  static Future<List<DefinitionEntrySense>?> fetch(String id) async {
    final response = await http.post(
      Uri.https('dlc.iec.cat', '/Results/Accepcio', {'id': id}),
      headers: const {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      debugPrint("Can't find definition");
      return null;
    }

    final responseBody = json.decode(response.body) as Map<String, dynamic>;
    return _parseHtml(responseBody['content'] as String);
  }

  static List<DefinitionEntrySense> _parseHtml(String content) {
    final document = html.parse(content);
    final body = document.getElementsByTagName('body').first;

    final definitions = <List<Element>>[];
    final tempDefinitionElements = <Element>[];

    for (final child in body.children) {
      if (child.localName == 'br') {
        if (tempDefinitionElements.isNotEmpty) {
          definitions.add(tempDefinitionElements.toList());
          tempDefinitionElements.clear();
        }
        continue;
      }

      if (child.localName == 'span') {
        tempDefinitionElements.add(child);
      }
    }

    if (tempDefinitionElements.isNotEmpty) {
      definitions.add(tempDefinitionElements.toList());
      tempDefinitionElements.clear();
    }

    return fromElements(definitions);
  }
}
