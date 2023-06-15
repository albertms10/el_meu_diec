// ignore_for_file: lines_longer_than_80_chars

import 'dart:convert';
import 'dart:developer';

import 'package:el_meu_diec/src/model/definition_entry_sense.dart';
import 'package:flutter/foundation.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as html show parse;
import 'package:http/http.dart' as http;

// ignore: avoid_classes_with_only_static_members
extension DefinitionEntrySenses on List<DefinitionEntrySense> {
  static List<DefinitionEntrySense> fromElements(
    List<List<Element>> elements,
  ) =>
      [
        for (final element in elements)
          DefinitionEntrySense.fromElements(element),
      ];

  static Future<String?> fetch(String id) async {
    final response = await http.post(
      Uri.parse(
        "${Uri.https('dlc.iec.cat', '/Results/Accepcio', {
              'id': id
            })}&searchParam%5BIdE%5D=&searchParam%5BEntradaText%5D=al%C2%B7legoria&searchParam%5BDecEntradaText%5D=al%C2%B7legoria&searchParam%5BCatGram%5D=&searchParam%5BAreaTem%5D=&searchParam%5BAvailableAreaTem%5D=&searchParam%5BLlenguaOrigen%5D=&searchParam%5BDefinicioText%5D=&searchParam%5BExampleText%5D=&searchParam%5BSubEntradaText%5D=&searchParam%5BMarcaVal%5D=&searchParam%5BInfoMorf%5D=&searchParam%5BAllInfoMorf%5D=false&searchParam%5BOperEntrada%5D=0&searchParam%5BOperDef%5D=0&searchParam%5BOperEx%5D=0&searchParam%5BOperSubEntrada%5D=0&searchParam%5BOperAreaTematica%5D=0&searchParam%5BInfoMorfType%5D=0&searchParam%5BOperCatGram%5D=false&searchParam%5BAccentSen%5D=false&searchParam%5BCurrentPage%5D=0&searchParam%5BrefineSearch%5D=0&searchParam%5BSearchResult%5D=&searchParam%5BAdvancedSearch%5D=&searchParam%5BShareContent%5D%5BEntrada%5D=al%C2%B7legoria&searchParam%5BShareContent%5D%5BUrl%5D=https%3A%2F%2Fdlc.iec.cat%2FResults%3FEntradaText%3Dal%25c2%25b7legoria%26OperEntrada%3D0&searchParam%5BShareContent%5D%5BDescription%5D=Consulteu+l'entrada+al%C2%B7legoria+a+la+web+del+DIEC2+&searchParam%5BShareContent%5D%5BImageURL%5D=https%3A%2F%2Fdlc.iec.cat%2Fimg%2FDiec2AppLogo.png&searchParam%5BShareContent%5D%5BImageFacebookURL%5D=https%3A%2F%2Fdlc.iec.cat%2Fimg%2FDiec2AppLogo1.png&searchParam%5BActualitzacions%5D=false",
      ),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      debugPrint("Can't find definition");
      return null;
    }

    final responseBody = json.decode(response.body) as Map<String, dynamic>;

    // final maxNumAcc = responseBody['maxNumAcc'];
    // final curNumAcc = responseBody['curNumAcc'];
    final document = html.parse(responseBody['content']);
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

    final e = fromElements(definitions);
    inspect(e);

    return '';
  }
}
