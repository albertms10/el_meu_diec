import 'package:flutter/foundation.dart' show immutable, listEquals;
import 'package:html/dom.dart';

import 'gender.dart';
import 'scope.dart';

@immutable
class DefinitionEntrySense {
  final int? number;
  final int? subNumber;
  final Gender? gender;
  final List<Scope> scopes;
  final String? locution;
  final String? definition;

  const DefinitionEntrySense({
    this.number,
    this.subNumber,
    this.gender,
    this.scopes = const <Scope>[],
    this.locution,
    this.definition,
  });

  static int? parseNumber(Element element) {
    if (element.localName == 'b') return int.tryParse(element.text.trim());

    return null;
  }

  static int? parseSubNumber(Element element) {
    if (element.localName == 'i') return int.tryParse(element.text.trim());

    return null;
  }

  static String? parseLocution(Element element) {
    final child = element.children.firstOrNull;
    if (child?.className == 'bolditalic') return child!.innerHtml.trim();

    return null;
  }

  static (String?, String?) parseDefinitionAndLocution(Element element) {
    String? definition;
    final textNode = element.nodes.lastOrNull;
    if (textNode?.nodeType == Node.TEXT_NODE) {
      final trimmedText = textNode!.text?.trim();
      if (trimmedText?.isNotEmpty ?? false) definition = trimmedText;
    }

    return (definition, parseLocution(element));
  }

  factory DefinitionEntrySense.fromElements(List<Element> elements) {
    int? number;
    int? subNumber;
    Gender? gender;
    final scopes = <Scope>[];
    String? locution;
    String? definition;

    for (final element in elements) {
      if (element.localName != 'span') continue;
      if (gender == null) {
        gender = Gender.parse(element);
        if (gender != null) continue;
      }
      if (definition == null) {
        (definition, locution) =
            DefinitionEntrySense.parseDefinitionAndLocution(element);
      }

      for (final child in element.children) {
        if (number == null) {
          number = DefinitionEntrySense.parseNumber(child);
          if (number != null) continue;
        }
        if (subNumber == null) {
          subNumber = DefinitionEntrySense.parseSubNumber(child);
          if (subNumber != null) continue;
        }

        final scope = Scope.parse(child);
        if (scope != null) {
          scopes.add(scope);
          continue;
        }
      }
    }

    return DefinitionEntrySense(
      number: number,
      subNumber: subNumber,
      gender: gender,
      scopes: scopes,
      locution: locution,
      definition: definition,
    );
  }

  @override
  String toString() => [
        'number: $number',
        'subNumber: $subNumber',
        'gender: $gender',
        'scopes: $scopes',
        'locution: $locution',
        'definition: $definition',
      ].join('\n');

  @override
  bool operator ==(Object other) =>
      other is DefinitionEntrySense &&
      number == other.number &&
      subNumber == other.subNumber &&
      gender == other.gender &&
      listEquals(scopes, other.scopes) &&
      locution == other.locution &&
      definition == other.definition;

  @override
  int get hashCode =>
      Object.hash(number, subNumber, gender, scopes, locution, definition);
}
