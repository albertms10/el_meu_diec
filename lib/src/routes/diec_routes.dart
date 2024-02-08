import 'package:flutter/foundation.dart';

import '../model/word.dart';

@immutable
final class DIECRoutes {
  final String authority;

  const DIECRoutes({this.authority = 'dlc.iec.cat'});

  Uri wordUri(Word word) => Uri.https(authority, '/Results', {
        'IdE': word.id,
        'DecEntradaText': word.word,
      });
}
