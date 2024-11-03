import 'package:html/dom.dart';
import 'package:html/parser.dart' as html show parse;

import '../repositories/diec_repository.dart';
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
    final responseBody = await const DIECRepository().definitionEntries(id);
    final document = html.parse(responseBody['content']);
    final body = document.getElementsByTagName('body').first;

    final definitions = <List<Element>>[];
    final tempDefinitionElements = <Element>[];

    for (final child in body.children) {
      switch (child) {
        case Element(localName: 'br') when tempDefinitionElements.isNotEmpty:
          definitions.add(tempDefinitionElements.toList());
          tempDefinitionElements.clear();
        case Element(localName: 'span'):
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
