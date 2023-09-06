import 'package:flutter/material.dart';

class CustomTheme {
  static final theme = ThemeData(
    useMaterial3: true,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16), gapPadding: 5),
      isDense: true,
    ),
  );
}
