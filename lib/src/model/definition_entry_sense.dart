import 'package:el_meu_diec/src/utils/enum_try_by_name_extension.dart';
import 'package:html/dom.dart';

enum Gender { f, m }

class DefinitionEntrySense {
  final int? number;
  final int? subNumber;
  final Gender? gender;
  final List<String> scopes;
  final String? definition;

  DefinitionEntrySense({
    this.number,
    this.subNumber,
    this.gender,
    this.scopes = const [],
    this.definition,
  });

  factory DefinitionEntrySense.fromElements(List<Element> elements) {
    int? number;
    int? subNumber;
    Gender? gender;
    final scopes = <String>[];
    String? definition;

    for (final element in elements) {
      if (element.localName != 'span') continue;

      if (element.classes.contains('tagline')) {
        gender = Gender.values.tryByName(element.text.substring(0, 1));
        continue;
      }

      for (final child in element.children) {
        switch (child.localName) {
          case 'b':
            number = int.tryParse(child.text.trim());
            continue;

          case 'i':
            subNumber = int.tryParse(child.text.trim());
            continue;

          case 'span':
            if (child.classes.contains('tip')) {
              scopes.add(child.text.trim());
              continue;
            }
        }
      }
    }

    return DefinitionEntrySense(
      number: number,
      subNumber: subNumber,
      gender: gender,
      scopes: scopes,
      definition: definition,
    );
  }

  @override
  String toString() => [
        if (number != null) number,
        if (subNumber != null) subNumber,
        if (gender != null) '${gender!.name}.',
        scopes.join(' '),
        if (definition != null) definition
      ].join(' ');
}
