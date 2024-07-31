extension StringExtension on String {
  static final _wordsRegExp = RegExp(r'([a-zA-Zà-üÀ-Ü·\[\] -])*');

  String get stripNumbers => _wordsRegExp.stringMatch(this) ?? '';
}
