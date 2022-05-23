import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

const kPrimary = Colors.blue;

ThemeData defaultTheme() {
  return ThemeData(
    fontFamily: "IranianSans",
    primaryColor: kPrimary,
    colorScheme: const ColorScheme.light(primary: kPrimary),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
    ),
    inputDecorationTheme: filledInputDecoration(),
    elevatedButtonTheme: elevatedButtonTheme(),
  );
}

InputDecorationTheme filledInputDecoration() {
  return InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(cornerRadius),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(cornerRadius),
      borderSide: const BorderSide(width: 2, color: Colors.red),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(cornerRadius),
      borderSide: const BorderSide(width: 2, color: kPrimary),
    ),
    filled: true,
    fillColor: Colors.grey.withOpacity(0.2),
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
  );
}

ElevatedButtonThemeData elevatedButtonTheme() => ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(vertical: 12, horizontal: 24)),
        shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cornerRadius))),
        // foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
    );
