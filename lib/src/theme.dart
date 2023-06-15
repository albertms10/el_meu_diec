import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final _colorScheme = ColorScheme.fromSeed(seedColor: Colors.red);

const inputDecorationTheme = InputDecorationTheme(
  filled: true,
  fillColor: Colors.white,
  contentPadding: EdgeInsets.all(20),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30)),
    borderSide: BorderSide.none,
  ),
);

final playfairDisplayTextTheme =
    GoogleFonts.playfairDisplayTextTheme().headline5!.copyWith(fontSize: 24);

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
