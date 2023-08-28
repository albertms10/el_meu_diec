import 'package:el_meu_diec/src/utils/enum_try_by_name_extension.dart';
import 'package:html/dom.dart';

enum Gender {
  f,
  m;

  static Gender? parse(Element element) {
    if (element.classes.contains('tagline')) {
      return Gender.values.tryByName(element.text.substring(0, 1));
    }

    return null;
  }

  @override
  String toString() => '$name.';
}
