import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final _colorScheme = ColorScheme.fromSeed(seedColor: Colors.red);
const borderRadius = BorderRadius.all(Radius.circular(30));

final defaultInputBorder = OutlineInputBorder(
  borderRadius: borderRadius,
  borderSide: BorderSide(color: _colorScheme.primary, width: 2),
);

final inputDecorationTheme = InputDecorationTheme(
  hintStyle: const TextStyle(fontSize: 18, color: Colors.grey),
  filled: true,
  fillColor: Colors.white,
  contentPadding: const EdgeInsets.all(20),
  border: defaultInputBorder,
  enabledBorder: defaultInputBorder.copyWith(
    borderSide: const BorderSide(color: Colors.grey),
  ),
  focusedBorder: defaultInputBorder,
);

final playfairDisplayTextTheme = GoogleFonts.playfairDisplayTextTheme()
    .headlineSmall!
    .copyWith(fontSize: 24);

final lightThemeData = ThemeData.light().copyWith(
  useMaterial3: true,
  colorScheme: _colorScheme,
  inputDecorationTheme: inputDecorationTheme,
);

final darkThemeData = ThemeData.dark().copyWith(
  useMaterial3: true,
  colorScheme: _colorScheme,
  inputDecorationTheme: inputDecorationTheme,
);
