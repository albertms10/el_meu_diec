// ignore_for_file: constant_identifier_names

import 'package:el_meu_diec/src/utils/enum_try_by_name_extension.dart';
import 'package:html/dom.dart';

enum Scope {
  AD('llenguatge administratiu'),
  AF('arts gràfiques'),
  AGA('agricultura'),
  AGF('ciència forestal'),
  AGP('pesca'),
  AGR('explotació animal'),
  AN('antropologia'),
  AQ('arquitectura'),
  AR('art'),
  BB('biblioteconomia'),
  BI('biologia'),
  BO('botànica en general'),
  BOB('fongs i líquens'),
  BOC('col·lectius vegetals'),
  BOI('plantes inferiors '),
  BOS('plantes superiors'),
  BOT('botànica '),
  CO('comunicació'),
  DE('defensa'),
  DR('dret'),
  ECO('oficines'),
  ECT('teoria econòmica'),
  ED('economia domèstica'),
  EE('enginyeria elèctrica'),
  EG('ecologia'),
  EI('enginyeria industrial general'),
  EL('enginyeria electrònica'),
  ENG('enginyeries'),
  FIA('astronomia'),
  FIF('física en general'),
  FIM('metrologia'),
  FIN('física nuclear'),
  FL('filologia'),
  FLL('literatura'),
  FS('filosofia'),
  GEO('geologia'),
  GG('geografia'),
  GL('geologia en general'),
  GLG('mineralogia en general'),
  GLM('minerals'),
  GLP('paleontologia'),
  HIA('arqueologia'),
  HIG('genealogia i heràldica'),
  HIH('història en general'),
  HO('hoteleria'),
  IMF('indústria de la fusta'),
  IMI('indústries en general'),
  IN('informàtica'),
  IND('indústries'),
  IQ('indústria química'),
  IQA('adoberia'),
  ISL('islam'),
  IT('indústria tèxtil'),
  JE('jocs i espectacles'),
  LC('lèxic comú'),
  MD('medicina i farmàcia'),
  ME('meteorologia'),
  MI('mineria'),
  ML('metal·lúrgia'),
  MT('matemàtiques'),
  MU('música'),
  NU('numismàtica'),
  OP('obres públiques'),
  PE('pedagogia'),
  PO('política'),
  PR('professions'),
  PS('psicologia'),
  QU('química'),
  RE('religió'),
  SO('sociologia'),
  SP('esports'),
  TC('telecomunicació'),
  TRA('transports per aigua'),
  TRG('transports en general'),
  VE('veterinària'),
  ZO('zoologia'),
  ZOA('zoologia en general'),
  ZOI('invertebrats'),
  ZOM('mamífers'),
  ZOO('ocells'),
  ZOP('peixos'),
  ZOR('amfibis i rèptils');

  const Scope(this.label);

  final String label;

  static Scope? parse(Element element) {
    if (element.localName == 'span' && element.classes.contains('tip')) {
      return values.tryByName(
        element.text.trim().replaceAll(RegExp(r'\[|\]'), ''),
      );
    }

    return null;
  }

  @override
  String toString() => '[$name]';
}
