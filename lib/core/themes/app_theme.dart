import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 96, 59, 181),
    brightness: Brightness.dark);
var kColorSchemeDark =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 5, 199, 125));

final darkTheme = ThemeData.dark().copyWith(
    useMaterial3: true,
    colorScheme: kColorScheme,
    cardTheme: const CardTheme().copyWith(
        color: kColorSchemeDark.onSecondaryContainer,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: kColorSchemeDark.onPrimaryContainer,
          foregroundColor: kColorSchemeDark.onPrimary),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: kColorSchemeDark.onSecondary,
    ));
final theme = ThemeData().copyWith(
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: kColorScheme,
  cardTheme: const CardTheme().copyWith(
      color: kColorScheme.onSecondaryContainer,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: kColorScheme.onPrimaryContainer,
        foregroundColor: kColorScheme.onSecondary),
  ),
);
