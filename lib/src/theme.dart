import 'package:flutter/material.dart';

final _colorScheme = ColorScheme.fromSeed(seedColor: Colors.red);
const borderRadius = BorderRadius.all(Radius.circular(30));

const defaultInputBorder = OutlineInputBorder(
  borderRadius: borderRadius,
  borderSide: BorderSide.none,
);

final inputDecorationTheme = InputDecorationTheme(
  hintStyle: const TextStyle(fontSize: 18, color: Colors.grey),
  filled: true,
  fillColor: Colors.white,
  contentPadding: const EdgeInsetsDirectional.all(20),
  border: defaultInputBorder,
  enabledBorder: defaultInputBorder,
  focusedBorder: defaultInputBorder.copyWith(
    borderSide: BorderSide(color: _colorScheme.primary, width: 2),
  ),
);

final themeData = ThemeData(fontFamily: 'PlusJakartaSans');
final headlineTextTheme =
    themeData.textTheme.headlineSmall!.copyWith(fontSize: 24);
final bodyTextTheme = themeData.textTheme.bodyMedium!.copyWith(fontSize: 16);

final lightThemeData = ThemeData.light().copyWith(
  useMaterial3: true,
  colorScheme: _colorScheme,
  inputDecorationTheme: inputDecorationTheme,
  textTheme: themeData.textTheme,
);

final darkThemeData = ThemeData.dark().copyWith(
  useMaterial3: true,
  colorScheme: _colorScheme,
  inputDecorationTheme: inputDecorationTheme,
  textTheme: themeData.textTheme,
);
