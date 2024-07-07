// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sudoku/sudoku/sudoku.dart';
import 'package:sudoku/timer/timer.dart';

import '../../helpers/helpers.dart';

void main() {
  group('SudokuBoard', () {
    late TimerBloc timerBloc;

    const largeKey = Key('sudoku_board_large');
    const mediumKey = Key('sudoku_board_medium');
    const smallKey = Key('sudoku_board_small');

    setUp(() {
      timerBloc = MockTimerBloc();
      when(() => timerBloc.state).thenReturn(TimerState());
    });

    testWidgets('renders on a large layout', (tester) async {
      tester.setLargeDisplaySize();
      await tester.pumpApp(
        SudokuBoard(blocks: const []),
        timerBloc: timerBloc,
      );
      expect(find.byKey(largeKey), findsOneWidget);
    });

    testWidgets('renders on a medium layout', (tester) async {
      tester.setMediumDisplaySize();
      await tester.pumpApp(
        SudokuBoard(blocks: const []),
        timerBloc: timerBloc,
      );
      expect(find.byKey(mediumKey), findsOneWidget);
    });

    testWidgets('renders on a small layout', (tester) async {
      tester.setSmallDisplaySize();
      await tester.pumpApp(
        SudokuBoard(blocks: const []),
        timerBloc: timerBloc,
      );
      expect(find.byKey(smallKey), findsOneWidget);
    });

    testWidgets(
      'does not render [FloatingActionButton] when timer is running',
      (tester) async {
        when(() => timerBloc.state).thenReturn(
          TimerState(secondsElapsed: 5, isRunning: true),
        );
        await tester.pumpApp(
          SudokuBoard(blocks: const []),
          timerBloc: timerBloc,
        );
        expect(find.byType(FloatingActionButton), findsNothing);
      },
    );

    testWidgets(
      'renders [FloatingActionButton] when timer is paused',
      (tester) async {
        when(() => timerBloc.state).thenReturn(
          TimerState(secondsElapsed: 5, isRunning: false),
        );
        await tester.pumpApp(
          SudokuBoard(blocks: const []),
          timerBloc: timerBloc,
        );
        expect(find.byType(FloatingActionButton), findsOneWidget);
      },
    );

    testWidgets(
      'adds [TimerResumed] when tapped on [FloatingActionButton] widget',
      (tester) async {
        when(() => timerBloc.state).thenReturn(
          TimerState(secondsElapsed: 5, isRunning: false),
        );
        await tester.pumpApp(
          SudokuBoard(blocks: const []),
          timerBloc: timerBloc,
        );
        await tester.tap(find.byType(FloatingActionButton));
        verify(() => timerBloc.add(TimerResumed())).called(1);
      },
    );
  });
}
