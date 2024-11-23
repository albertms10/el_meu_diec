import 'package:flutter/foundation.dart' show immutable, listEquals;
import 'package:html/dom.dart';

import 'gender.dart';
import 'scope.dart';
import 'word.dart';

class ChainItem<T> {
  final T? Function()? value;
  final T Function(T)? set;
  final T? Function(Element)? function;
  final void Function(T)? transform;

  const ChainItem({this.value, this.set, this.function, this.transform});
}

@immutable
final class DefinitionEntrySense {
  final int? number;
  final int? subNumber;
  final Gender? gender;
  final List<Scope> scopes;
  final String? locution;
  final String? definition;
  final Word? redirectWord;
  final List<String> examples;

  const DefinitionEntrySense({
    this.number,
    this.subNumber,
    this.gender,
    this.scopes = const <Scope>[],
    this.locution,
    this.definition,
    this.redirectWord,
    this.examples = const <String>[],
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
      if ((trimmedText?.isNotEmpty ?? false) && trimmedText!.hasWords) {
        definition = trimmedText;
      }
    }

    return (definition, parseLocution(element));
  }

  static final _wordIdRegExp = RegExp(r"'(\d+)'");
  static final _redirectWordRegExp =
      RegExp('(?:v. )?(.+)', caseSensitive: false);

  static Word? parseRedirectEntry(Element element) {
    if (element.className != 'versaleta') return null;
    final child = element.children.firstOrNull;
    if (child?.localName != 'a') return null;
    final hrefAttribute = child!.attributes['href'];
    if (hrefAttribute == null) return null;

    final wordIdMatch = _wordIdRegExp.firstMatch(hrefAttribute);
    if (wordIdMatch == null || wordIdMatch[1] == null) return null;

    final wordNameMatch = _redirectWordRegExp.firstMatch(child.innerHtml);
    if (wordNameMatch == null) return null;

    return Word(id: wordIdMatch[1]!, word: wordNameMatch[1]!);
  }

  static String? parseExample(Element element) {
    if (element.className != 'italic') return null;

    return element.text.trim();
  }

  factory DefinitionEntrySense.fromElements(List<Element> elements) {
    int? number;
    int? subNumber;
    Gender? gender;
    final scopes = <Scope>[];
    String? locution;
    String? definition;
    Word? redirectWord;
    final examples = <String>[];

    for (final element in elements) {
      if (element.localName != 'span') continue;
      if (gender == null) {
        gender = Gender.parse(element);
        if (gender != null) continue;
      }
      if (definition == null) {
        (definition, locution) = parseDefinitionAndLocution(element);
      }

      final chain = [
        ChainItem(
          value: () => number,
          set: (dynamic newNumber) => number = newNumber as int,
          function: parseNumber,
        ),
        ChainItem(
          value: () => subNumber,
          set: (dynamic newSubNumber) => number = newSubNumber as int,
          function: parseSubNumber,
        ),
        ChainItem<Scope>(function: Scope.parse, transform: scopes.add),
        ChainItem(value: () => redirectWord, function: parseRedirectEntry),
        ChainItem<String>(function: parseExample, transform: examples.add),
      ];

      for (final child in element.children) {
        for (final chainElement in chain) {
          if (chainElement.value?.call() != null) continue;
          final value = chainElement.function?.call(child);
          if (value != null) {
            final newElement = chainElement.set?.call(value);
            if (newElement != null) continue;
          }
        }

        if (number == null) {
          number = parseNumber(child);
          if (number != null) continue;
        }
        if (subNumber == null) {
          subNumber = parseSubNumber(child);
          if (subNumber != null) continue;
        }

        final scope = Scope.parse(child);
        if (scope != null) {
          scopes.add(scope);
          continue;
        }

        if (redirectWord == null) {
          redirectWord = parseRedirectEntry(child);
          if (redirectWord != null) continue;
        }

        final example = parseExample(child);
        if (example != null) examples.add(example);
      }
    }

    return DefinitionEntrySense(
      number: number,
      subNumber: subNumber,
      gender: gender,
      scopes: scopes,
      locution: locution,
      definition: definition,
      redirectWord: redirectWord,
      examples: examples,
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
        'redirectWord: $redirectWord',
        'examples: $examples',
      ].join('\n');

  @override
  bool operator ==(Object other) =>
      other is DefinitionEntrySense &&
      number == other.number &&
      subNumber == other.subNumber &&
      gender == other.gender &&
      listEquals(scopes, other.scopes) &&
      locution == other.locution &&
      definition == other.definition &&
      redirectWord == other.redirectWord &&
      listEquals(examples, other.examples);

  @override
  int get hashCode => Object.hash(
        number,
        subNumber,
        gender,
        Object.hashAll(scopes),
        locution,
        definition,
        redirectWord,
        Object.hashAll(examples),
      );
}

extension on String {
  static final _wordRegExp = RegExp(r'\w');

  bool get hasWords => _wordRegExp.hasMatch(this);
}
