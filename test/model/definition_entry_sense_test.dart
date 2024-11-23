// ignore_for_file: lines_longer_than_80_chars

import 'package:el_meu_diec/model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:html/parser.dart';

void main() {
  group('DefinitionEntrySense', () {
    group('.fromElements()', () {
      test(
          'should create a new DefinitionEntrySense '
          '{number, subNumber, gender, scopes, definition}', () {
        expect(
          DefinitionEntrySense.fromElements(
            parseFragment('''
<span class="body" xmlns:fo="http://www.w3.org/1999/XSL/Format"><b>1&nbsp;</b><i>1&nbsp;</i></span><span class="tagline" xmlns:fo="http://www.w3.org/1999/XSL/Format">f.</span><span class="body" xmlns:fo="http://www.w3.org/1999/XSL/Format"> <span class="tip" onmouseover="doTooltip(event, ' [LC] ' )" onmouseout="hideTip()"> [LC] </span> </span><span class="body" xmlns:fo="http://www.w3.org/1999/XSL/Format">Allò que representa una cosa per semblança suggestiva, emblema. </span>
''').children,
          ),
          const DefinitionEntrySense(
            number: 1,
            subNumber: 1,
            gender: Gender.f,
            scopes: [Scope.LC],
            definition:
                'Allò que representa una cosa per semblança suggestiva, '
                'emblema.',
          ),
        );
      });

      test(
          'should create a new DefinitionEntrySense '
          '{number, gender, scopes, definition, single example}', () {
        expect(
          DefinitionEntrySense.fromElements(
            parseFragment('''
<span class="body" xmlns:fo="http://www.w3.org/1999/XSL/Format"><b>4 </b></span> <span class="tagline" xmlns:fo="http://www.w3.org/1999/XSL/Format">m.</span> <span class="body" xmlns:fo="http://www.w3.org/1999/XSL/Format"> <span class="tip" onmouseover="doTooltip(event, ' [FS] ' )" onmouseout="hideTip()"> [FS] </span> </span><span class="body" xmlns:fo="http://www.w3.org/1999/XSL/Format">En fil., estat de realitat o existència real. </span><span class="body" xmlns:fo="http://www.w3.org/1999/XSL/Format"><span class="italic">Passar de la potència a l’acte. </span></span><br xmlns:fo="http://www.w3.org/1999/XSL/Format">
''').children,
          ),
          const DefinitionEntrySense(
            number: 4,
            gender: Gender.m,
            scopes: [Scope.FS],
            definition: 'En fil., estat de realitat o existència real.',
            examples: ['Passar de la potència a l’acte.'],
          ),
        );
      });

      test(
          'should create a new DefinitionEntrySense '
          '{number, subNumber, scopes, locution, definition}', () {
        expect(
          DefinitionEntrySense.fromElements(
            parseFragment('''
<span class="body" xmlns:fo="http://www.w3.org/1999/XSL/Format"><b>6 </b> <i>2 </i></span>  <span class="body" xmlns:fo="http://www.w3.org/1999/XSL/Format"><span class="tip" onmouseover="doTooltip(event, ' [JE] ' )" onmouseout="hideTip()"> [JE] </span><span class="tip" onmouseover="doTooltip(event, ' [RE] ' )" onmouseout="hideTip()"> [RE] </span>  </span><span class="body" xmlns:fo="http://www.w3.org/1999/XSL/Format"><span class="bolditalic"> acte sacramental </span>Peça dramàtica en un acte, de caràcter al·legòric, per a l’exaltació de l’eucaristia. </span>
''').children,
          ),
          const DefinitionEntrySense(
            number: 6,
            subNumber: 2,
            scopes: [Scope.JE, Scope.RE],
            locution: 'acte sacramental',
            definition:
                'Peça dramàtica en un acte, de caràcter al·legòric, per '
                'a l’exaltació de l’eucaristia.',
          ),
        );
      });

      test(
          'should create a new DefinitionEntrySense '
          '{scopes, redirectWord}', () {
        expect(
          DefinitionEntrySense.fromElements(
            parseFragment('''
<span class="body" xmlns:fo="http://www.w3.org/1999/XSL/Format"></span>  <span class="body" xmlns:fo="http://www.w3.org/1999/XSL/Format"> <span class="tip" onmouseover="doTooltip(event, ' [LC] ' )" onmouseout="hideTip()"> [LC] </span><span class="tip" onmouseover="doTooltip(event, ' [ZOI] ' )" onmouseout="hideTip()"> [ZOI] </span> </span><span class="body" xmlns:fo="http://www.w3.org/1999/XSL/Format"><span class="versaleta"><A href="javascript:GetFullAccepcio('0038511')">V. caragol</A></span>. </span>
''').children,
          ),
          const DefinitionEntrySense(
            scopes: [Scope.LC, Scope.ZOI],
            redirectWord: Word(id: '0038511', word: 'caragol'),
          ),
        );
      });

      test(
          'should create a new DefinitionEntrySense '
          '{number, gender, scopes, redirectWord without v.}', () {
        expect(
          DefinitionEntrySense.fromElements(
            parseFragment('''
<span class="body" xmlns:fo="http://www.w3.org/1999/XSL/Format"><B>1 </B></span> <span class="tagline" xmlns:fo="http://www.w3.org/1999/XSL/Format">adj. <span class="rodona">i</span> m. <span class="rodona">i</span> f.</span> <span class="body" xmlns:fo="http://www.w3.org/1999/XSL/Format"> <span class="tip" onmouseover="doTooltip(event, ' [LC] ' )" onmouseout="hideTip()"> [LC] </span> </span><span class="body" xmlns:fo="http://www.w3.org/1999/XSL/Format"><span class="versaleta"><A href="javascript:GetFullAccepcio('0011665')">Neerlandès</A></span>.</span>
''').children,
          ),
          const DefinitionEntrySense(
            number: 1,
            scopes: [Scope.LC],
            redirectWord: Word(id: '0011665', word: 'Neerlandès'),
            definition: 'f.', // TODO(albertms10): should be `gender`.
          ),
        );
      });

      test(
          'should create a new DefinitionEntrySense '
          '{number, gender, scopes, multiple examples}', () {
        expect(
          DefinitionEntrySense.fromElements(
            parseFragment('''
<span class="body" xmlns:fo="http://www.w3.org/1999/XSL/Format"><B>1 </B><I>2 </I></span><span class="tagline" xmlns:fo="http://www.w3.org/1999/XSL/Format">intr.</span><span class="body" xmlns:fo="http://www.w3.org/1999/XSL/Format"> <span class="tip" onmouseover="doTooltip(event, ' [LC] ' )" onmouseout="hideTip()"> [LC] </span> </span><span class="body" xmlns:fo="http://www.w3.org/1999/XSL/Format"><span class="italic">Usar algú del seu dret. </span></span><span class="body" xmlns:fo="http://www.w3.org/1999/XSL/Format"><span class="italic">Usar algú malament de les riqueses. </span></span><span class="body" xmlns:fo="http://www.w3.org/1999/XSL/Format"><span class="italic">Useu del meu crèdit. </span></span><span class="body" xmlns:fo="http://www.w3.org/1999/XSL/Format"><span class="italic">Useu-ne, però no n’abuseu. </span></span>
''').children,
          ),
          const DefinitionEntrySense(
            number: 1,
            subNumber: 2,
            scopes: [Scope.LC],
            definition: 'intr.',
            examples: [
              'Usar algú del seu dret.',
              'Usar algú malament de les riqueses.',
              'Useu del meu crèdit.',
              'Useu-ne, però no n’abuseu.',
            ],
          ),
        );
      });

      test(
          'should create a new DefinitionEntrySense '
          '{number, gender, scopes, multiple examples}', () {
        expect(
          DefinitionEntrySense.fromElements(
            parseFragment('''
><span class="body" xmlns:fo="http://www.w3.org/1999/XSL/Format"><B>1 </B><I>1 </I></span><span class="tagline" xmlns:fo="http://www.w3.org/1999/XSL/Format">f.</span><span class="body" xmlns:fo="http://www.w3.org/1999/XSL/Format"> <span class="tip" onmouseover="doTooltip(event, ' [LC] ' )" onmouseout="hideTip()"> [LC] </span><span class="tip" onmouseover="doTooltip(event, ' [FL] ' )" onmouseout="hideTip()"> [FL] </span><span class="tip" onmouseover="doTooltip(event, ' [FLL] ' )" onmouseout="hideTip()"> [FLL] </span> </span><span class="body" xmlns:fo="http://www.w3.org/1999/XSL/Format">Traducció d’un text d’un idioma a un altre, tant en el sentit escolar com en el sentit de recreació artística. </span><span class="body" xmlns:fo="http://www.w3.org/1999/XSL/Format"><span class="italic">Versió llatina. </span></span><span class="body" xmlns:fo="http://www.w3.org/1999/XSL/Format"><span class="italic">Versió literal. </span></span><span class="body" xmlns:fo="http://www.w3.org/1999/XSL/Format"><span class="italic">La versió que Carles Riba feu de l’<span class="rodona">Odissea </span>és una obra cabdal de la poesia catalana. </span></span><span class="body" xmlns:fo="http://www.w3.org/1999/XSL/Format"><span class="italic">Versions de Hölderlin. </span></span>
''').children,
          ),
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
              // TODO(albertms10): parse italic style from `<span>` elements.
              'La versió que Carles Riba feu de l’Odissea és una obra cabdal de la poesia catalana.',
              'Versions de Hölderlin.',
            ],
          ),
        );
      });
    });
  });
}
