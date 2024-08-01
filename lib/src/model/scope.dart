// ignore_for_file: constant_identifier_names

import 'package:el_meu_diec/src/utils/enum_try_by_name_extension.dart';
import 'package:html/dom.dart';

enum Scope {
  /// llenguatge administratiu
  AD('llenguatge administratiu'),

  /// arts gràfiques
  AF('arts gràfiques'),

  /// agricultura
  AGA('agricultura'),

  /// ciència forestal
  AGF('ciència forestal'),

  /// pesca
  AGP('pesca'),

  /// explotació animal
  AGR('explotació animal'),

  /// antropologia
  AN('antropologia'),

  /// arquitectura
  AQ('arquitectura'),

  /// art
  AR('art'),

  /// biblioteconomia
  BB('biblioteconomia'),

  /// biologia
  BI('biologia'),

  /// botànica en general
  BO('botànica en general'),

  /// fongs i líquens
  BOB('fongs i líquens'),

  /// coŀlectius vegetals
  BOC('coŀlectius vegetals'),

  /// plantes inferiors
  BOI('plantes inferiors '),

  /// plantes superiors
  BOS('plantes superiors'),

  /// botànica
  BOT('botànica '),

  /// comunicació
  CO('comunicació'),

  /// defensa
  DE('defensa'),

  /// dret
  DR('dret'),

  /// oficines
  ECO('oficines'),

  /// teoria econòmica
  ECT('teoria econòmica'),

  /// economia domèstica
  ED('economia domèstica'),

  /// enginyeria elèctrica
  EE('enginyeria elèctrica'),

  /// ecologia
  EG('ecologia'),

  /// enginyeria industrial general
  EI('enginyeria industrial general'),

  /// enginyeria electrònica
  EL('enginyeria electrònica'),

  /// enginyeries
  ENG('enginyeries'),

  /// astronomia
  FIA('astronomia'),

  /// física en general
  FIF('física en general'),

  /// metrologia
  FIM('metrologia'),

  /// física nuclear
  FIN('física nuclear'),

  /// filologia
  FL('filologia'),

  /// literatura
  FLL('literatura'),

  /// filosofia
  FS('filosofia'),

  /// geologia
  GEO('geologia'),

  /// geografia
  GG('geografia'),

  /// geologia en general
  GL('geologia en general'),

  /// mineralogia en general
  GLG('mineralogia en general'),

  /// minerals
  GLM('minerals'),

  /// paleontologia
  GLP('paleontologia'),

  /// arqueologia
  HIA('arqueologia'),

  /// genealogia i heràldica
  HIG('genealogia i heràldica'),

  /// història en general
  HIH('història en general'),

  /// hoteleria
  HO('hoteleria'),

  /// indústria de la fusta
  IMF('indústria de la fusta'),

  /// indústries en general
  IMI('indústries en general'),

  /// informàtica
  IN('informàtica'),

  /// indústries
  IND('indústries'),

  /// indústria química
  IQ('indústria química'),

  /// adoberia
  IQA('adoberia'),

  /// islam
  ISL('islam'),

  /// indústria tèxtil
  IT('indústria tèxtil'),

  /// jocs i espectacles
  JE('jocs i espectacles'),

  /// lèxic comú
  LC('lèxic comú'),

  /// medicina i farmàcia
  MD('medicina i farmàcia'),

  /// meteorologia
  ME('meteorologia'),

  /// mineria
  MI('mineria'),

  /// metaŀlúrgia
  ML('metaŀlúrgia'),

  /// matemàtiques
  MT('matemàtiques'),

  /// música
  MU('música'),

  /// numismàtica
  NU('numismàtica'),

  /// obres públiques
  OP('obres públiques'),

  /// pedagogia
  PE('pedagogia'),

  /// política
  PO('política'),

  /// professions
  PR('professions'),

  /// psicologia
  PS('psicologia'),

  /// química
  QU('química'),

  /// religió
  RE('religió'),

  /// sociologia
  SO('sociologia'),

  /// esports
  SP('esports'),

  /// telecomunicació
  TC('telecomunicació'),

  /// transports per aigua
  TRA('transports per aigua'),

  /// transports en general
  TRG('transports en general'),

  /// veterinària
  VE('veterinària'),

  /// zoologia
  ZO('zoologia'),

  /// zoologia en general
  ZOA('zoologia en general'),

  /// invertebrats
  ZOI('invertebrats'),

  /// mamífers
  ZOM('mamífers'),

  /// ocells
  ZOO('ocells'),

  /// peixos
  ZOP('peixos'),

  /// amfibis i rèptils
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
