// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sudoku/sudoku/sudoku.dart';
import 'package:sudoku/timer/timer.dart';

import '../../helpers/helpers.dart';

void main() {
  group('SudokuTimer', () {
    late TimerBloc timerBloc;

    setUp(() {
      timerBloc = MockTimerBloc();
      when(() => timerBloc.state).thenReturn(
        TimerState(secondsElapsed: 5, isRunning: true),
      );
    });

    testWidgets(
      'adds [TimerStopped] for tapping on the widget when Timer is running',
      (tester) async {
        await tester.pumpApp(SudokuTimer(), timerBloc: timerBloc);
        await tester.tap(find.byType(GestureDetector));
        verify(() => timerBloc.add(TimerStopped())).called(1);
      },
    );

    testWidgets(
      'adds [TimerResumed] for tapping on the widget when Timer is stopped',
      (tester) async {
        when(() => timerBloc.state).thenReturn(
          TimerState(secondsElapsed: 5, isRunning: false),
        );
        await tester.pumpApp(SudokuTimer(), timerBloc: timerBloc);
        await tester.tap(find.byType(GestureDetector));
        verify(() => timerBloc.add(TimerResumed())).called(1);
      },
    );

    testWidgets(
      'renders the pause icon when Timer is running',
      (tester) async {
        await tester.pumpApp(SudokuTimer(), timerBloc: timerBloc);
        expect(
          find.byWidgetPredicate(
            (widget) => widget is Icon && widget.icon == Icons.pause,
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'renders the play icon when Timer is stopped',
      (tester) async {
        when(() => timerBloc.state).thenReturn(
          TimerState(secondsElapsed: 5, isRunning: false),
        );
        await tester.pumpApp(SudokuTimer(), timerBloc: timerBloc);
        expect(
          find.byWidgetPredicate(
            (widget) => widget is Icon && widget.icon == Icons.play_arrow,
          ),
          findsOneWidget,
        );
      },
    );
  });
}
