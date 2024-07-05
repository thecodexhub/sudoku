import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/l10n/l10n.dart';
import 'package:sudoku/sudoku/sudoku.dart';

class _MockSudokuBloc extends MockBloc<SudokuEvent, SudokuState>
    implements SudokuBloc {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget, {SudokuBloc? sudokuBloc}) {
    return pumpWidget(
      BlocProvider<SudokuBloc>.value(
        value: sudokuBloc ?? _MockSudokuBloc(),
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: widget,
        ),
      ),
    );
  }
}
