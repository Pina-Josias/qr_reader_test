import 'package:flutter/material.dart';

/// Component global for application theme
class AppTheme {
  /// Returs application theme if the application is in light mode
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
    ),
  );

  /// Returs application theme if the application is in dark mode
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey[900],
    colorScheme: const ColorScheme.dark(),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[900],
    ),
  );
}
