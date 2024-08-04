import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:sudoku/api/api.dart';
import 'package:sudoku/home/home.dart';
import 'package:sudoku/l10n/l10n.dart';
import 'package:sudoku/puzzle/puzzle.dart';
import 'package:sudoku/repository/repository.dart';
import 'package:sudoku/timer/timer.dart';

import 'helpers.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    SudokuAPI? apiClient,
    PuzzleRepository? puzzleRepository,
    AuthenticationRepository? authenticationRepository,
    HomeBloc? homeBloc,
    TimerBloc? timerBloc,
    PuzzleBloc? puzzleBloc,
    Brightness? brightness,
    MockNavigator? navigator,
  }) {
    return pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<SudokuAPI>.value(
            value: apiClient ?? MockSudokuAPI(),
          ),
          RepositoryProvider<PuzzleRepository>.value(
            value: puzzleRepository ?? MockPuzzleRepository(),
          ),
          RepositoryProvider<AuthenticationRepository>.value(
            value: authenticationRepository ?? MockAuthenticationRepository(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<HomeBloc>.value(
              value: homeBloc ?? MockHomeBloc(),
            ),
            BlocProvider.value(
              value: timerBloc ?? MockTimerBloc(),
            ),
            BlocProvider.value(
              value: puzzleBloc ?? MockPuzzleBloc(),
            ),
          ],
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: ThemeData(brightness: brightness ?? Brightness.light),
            home: navigator != null
                ? MockNavigatorProvider(
                    navigator: navigator,
                    child: widget,
                  )
                : widget,
          ),
        ),
      ),
    );
  }
}
