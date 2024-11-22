// ignore_for_file: lines_longer_than_80_chars

import 'dart:convert' show json;
import 'dart:io' show File;

import 'package:el_meu_diec/model.dart';
import 'package:el_meu_diec/repositories.dart';
import 'package:flutter_test/flutter_test.dart';

class MockRepository extends DictionaryRepository {
  const MockRepository({super.authority = 'mock'});

  @override
  Future<Map<String, dynamic>> autocompleteEntries(
    String query, {
    required SearchCondition searchCondition,
  }) =>
      throw UnimplementedError();

  @override
  Future<Map<String, dynamic>> definitionEntries(String id) async =>
      json.decode(
        await File('test/fixtures/definitionEntries.json').readAsString(),
      ) as Map<String, dynamic>;
}

void main() {
  group('DefinitionEntrySenses', () {
    group('.fetch()', () {
      test('should fetch all senses from an entry', () async {
        expect(
          await DefinitionEntrySenses.fetch(
            '0084242',
            repository: const MockRepository(),
          ),
          [
            const DefinitionEntrySense(
              number: 1,
              subNumber: 1,
              gender: Gender.f,
              scopes: [Scope.LC, Scope.FL, Scope.FLL],
              definition:
                  'Traducció d’un text d’un idioma a un altre, tant en el '
                  'sentit escolar com en el sentit de recreació artística.',
              examples: [
                'Versió llatina.',
                'Versió literal.',
                'La versió que Carles Riba feu de l’Odissea és una obra cabdal de la poesia catalana.',
                'Versions de Hölderlin.',
              ],
            ),
            const DefinitionEntrySense(
              number: 1,
              subNumber: 2,
              scopes: [Scope.LC, Scope.JE],
              locution: 'versió subtitulada',
              definition: 'Adaptació d’un film conservant l’audició de la seva '
                  'llengua original i traduïda per mitjà de subtítols.',
            ),
            const DefinitionEntrySense(
              number: 2,
              subNumber: 1,
              gender: Gender.f,
              scopes: [Scope.LC],
              definition: 'Manera de referir una cosa contraposada a una altra '
                  'manera, manera d’interpretar els fets.',
              examples: ['Ell va donar una altra versió de l’afer.'],
            ),
            const DefinitionEntrySense(
              number: 2,
              subNumber: 2,
              gender: Gender.f,
              scopes: [Scope.LC, Scope.FLL, Scope.AR],
              definition:
                  'Estat d’un film, d’una obra literària, artística, etc., '
                  'que ha sofert modificacions.',
              examples: [
                'D’aquesta novel·la, se’n coneixen quatre versions.',
                'La versió original d’un film.',
              ],
            ),
            const DefinitionEntrySense(
              number: 3,
              subNumber: 1,
              gender: Gender.f,
              scopes: [Scope.MD],
              definition: 'En med., acció o cosa que presenta desviació.',
            ),
            const DefinitionEntrySense(
              number: 3,
              subNumber: 2,
              gender: Gender.f,
              scopes: [Scope.MD],
              definition: 'Desviació d’un òrgan cap endavant, cap endarrere '
                  'o cap als costats.',
            ),
            const DefinitionEntrySense(
              number: 3,
              subNumber: 3,
              gender: Gender.f,
              scopes: [Scope.MD],
              definition:
                  'En obstetrícia, operació manual per a tombar el fetus '
                  'en l’úter quan es presenta malament per al part.',
            ),
          ],
        );
      });
    });
  });
}
