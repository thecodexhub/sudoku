import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/l10n/l10n.dart';
import 'package:sudoku/sudoku/sudoku.dart';

import 'helpers.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget, {SudokuBloc? sudokuBloc}) {
    return pumpWidget(
      BlocProvider<SudokuBloc>.value(
        value: sudokuBloc ?? MockSudokuBloc(),
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: widget,
        ),
      ),
    );
  }
}
