import 'package:flutter/material.dart';

/// Defines the colors used in the Sudoku App UI.
abstract class SudokuColors {
  /// dark Pink
  static const lightPink = Color(0xFFFF63A4);

  /// Light Purple
  static const lightPurple = Color(0xFF7067FA);

  /// Dark Pink
  static const darkPink = Color(0xFFFC1FA4);

  /// Dark Pink background
  static const darkPinkBackground = Color(0x59FC1FA4);

  /// Dark Purple
  static const darkPurple = Color(0xFF5E33FD);

  /// Dark Purple background
  static const darkPurpleBackground = Color(0x9E5F33FD);

  /// Green
  static const green = Color(0xFF388E3C);

  /// Amber
  static const amber = Color(0xFFEBB208);

  /// Orange
  static const orange = Color(0xFFF57C00);

  /// Teal
  static const teal = Color(0xFF008577);

  /// Returns pink background color depending upon theme brightness.
  static Color getPinkBackground(BuildContext context) {
    final theme = Theme.of(context);
    if (theme.brightness == Brightness.light) return lightPink;
    return darkPinkBackground;
  }

  /// Returns purple background color depending upon theme brightness.
  static Color getPurpleBackground(BuildContext context) {
    final theme = Theme.of(context);
    if (theme.brightness == Brightness.light) return lightPurple;
    return darkPurpleBackground;
  }

  /// Returns pink color depending upon theme brightness.
  static Color getPink(BuildContext context) {
    final theme = Theme.of(context);
    if (theme.brightness == Brightness.light) return darkPink;
    return lightPink;
  }

  /// Returns purple color depending upon theme brightness.
  static Color getPurple(BuildContext context) {
    final theme = Theme.of(context);
    if (theme.brightness == Brightness.light) return darkPurple;
    return lightPurple;
  }
}
