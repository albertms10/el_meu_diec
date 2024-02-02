import 'dart:ui';

import 'package:flutter/material.dart';

const _color = Colors.red;
const inputBorderRadius = BorderRadius.all(Radius.circular(32));
const _defaultInputBorder = OutlineInputBorder(
  borderRadius: inputBorderRadius,
  borderSide: BorderSide.none,
);

InputDecorationTheme _inputDecorationTheme(ColorScheme colorScheme) =>
    InputDecorationTheme(
      hintStyle: const TextStyle(fontSize: 18, color: Colors.grey),
      filled: true,
      fillColor: colorScheme.brightness == Brightness.light
          ? Colors.white
          : Colors.black,
      contentPadding: const EdgeInsetsDirectional.all(20),
      border: _defaultInputBorder,
      enabledBorder: _defaultInputBorder,
      focusedBorder: _defaultInputBorder.copyWith(
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
      ),
    );

const _fontFamily = 'PlusJakartaSans';

final lightColorScheme = ColorScheme.fromSeed(seedColor: _color);
final lightThemeData = ThemeData(
  brightness: Brightness.light,
  colorScheme: lightColorScheme,
  inputDecorationTheme: _inputDecorationTheme(lightColorScheme),
  fontFamily: _fontFamily,
);

final darkColorScheme =
    ColorScheme.fromSeed(seedColor: _color, brightness: Brightness.dark);
final darkThemeData = ThemeData(
  brightness: Brightness.dark,
  colorScheme: darkColorScheme,
  inputDecorationTheme: _inputDecorationTheme(darkColorScheme),
  fontFamily: _fontFamily,
);

extension MyTextTheme on TextTheme {
  TextStyle get headlineTextStyle => headlineSmall!.copyWith(fontSize: 24);

  TextStyle get bodyTextStyle => bodyMedium!.copyWith(fontSize: 16);

  TextStyle get proportionalFiguresTextStyle => bodyTextStyle.copyWith(
        fontFeatures: const [FontFeature.proportionalFigures()],
      );
}
