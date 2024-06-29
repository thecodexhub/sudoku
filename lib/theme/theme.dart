import 'package:flutter/material.dart';

/// Defines [ThemeData] for Sudoku App UI.
class SudokuTheme {
  /// Light theme with blue accent
  static ThemeData get light {
    return ThemeData(
      scaffoldBackgroundColor: const Color(0xFFF8F8F8),
      appBarTheme: const AppBarTheme(
        color: Color(0xFFF8F8F8), // Light background color
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF3F51B5), // Blue accent color
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3F51B5),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF3F51B5),
        foregroundColor: Colors.white,
      ),
    );
  }

  /// Dark theme with same blue accent
  static ThemeData get dark {
    return ThemeData(
      scaffoldBackgroundColor: const Color(0xFF212121),
      appBarTheme: const AppBarTheme(
        color: Color(0xFF212121), // Dark background color
      ),
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: const Color(0xFF3F51B5), // Blue accent color
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3F51B5),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF3F51B5),
        foregroundColor: Colors.white,
      ),
    );
  }
}
