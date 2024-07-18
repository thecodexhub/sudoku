import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/api/api.dart';
import 'package:sudoku/home/home.dart';
import 'package:sudoku/l10n/l10n.dart';
import 'package:sudoku/sudoku/sudoku.dart';
import 'package:sudoku/timer/timer.dart';

import 'helpers.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    SudokuAPI? apiClient,
    HomeBloc? homeBloc,
    SudokuBloc? sudokuBloc,
    TimerBloc? timerBloc,
  }) {
    return pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<SudokuAPI>.value(
            value: apiClient ?? MockSudokuAPI(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<HomeBloc>.value(
              value: homeBloc ?? MockHomeBloc(),
            ),
            BlocProvider<SudokuBloc>.value(
              value: sudokuBloc ?? MockSudokuBloc(),
            ),
            BlocProvider.value(
              value: timerBloc ?? MockTimerBloc(),
            ),
          ],
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: widget,
          ),
        ),
      ),
    );
  }
}
