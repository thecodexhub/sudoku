import 'package:flutter/material.dart';
import 'package:sudoku/l10n/l10n.dart';
import 'package:sudoku/sudoku/sudoku.dart';
import 'package:sudoku/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: SudokuTheme.light,
      darkTheme: SudokuTheme.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const SudokuPage(),
    );
  }
}
