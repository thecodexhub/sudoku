// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sudoku/puzzle/puzzle.dart';
import 'package:sudoku/widgets/widgets.dart';

import '../../helpers/helpers.dart';

void main() {
  group('AskHintButton', () {
    late Puzzle puzzle;
    late PuzzleState puzzleState;
    late PuzzleBloc puzzleBloc;

    setUp(() {
      puzzle = MockPuzzle();
      puzzleState = MockPuzzleState();
      puzzleBloc = MockPuzzleBloc();

      when(() => puzzle.remainingHints).thenReturn(3);
      when(() => puzzleState.hintStatus).thenReturn(HintStatus.initial);
      when(() => puzzleState.puzzle).thenReturn(puzzle);

      when(() => puzzleBloc.state).thenReturn(puzzleState);
    });

    testWidgets('renders on a large layout', (tester) async {
      tester.setLargeDisplaySize();
      await tester.pumpApp(AskHintButton(), puzzleBloc: puzzleBloc);

      expect(find.byType(Column), findsOneWidget);
    });

    testWidgets('renders on a medium layout', (tester) async {
      tester.setMediumDisplaySize();
      await tester.pumpApp(AskHintButton(), puzzleBloc: puzzleBloc);

      expect(find.byType(Column), findsOneWidget);
    });

    testWidgets('renders on a small layout', (tester) async {
      tester.setSmallDisplaySize();
      await tester.pumpApp(AskHintButton(), puzzleBloc: puzzleBloc);

      expect(find.byType(Column), findsOneWidget);
    });

    testWidgets(
      'adds [SudokuHintRequested] when button is clicked',
      (tester) async {
        await tester.pumpApp(AskHintButton(), puzzleBloc: puzzleBloc);
        final finder = find.byType(SudokuElevatedButton);

        await tester.tap(finder);
        await tester.pump();

        verify(() => puzzleBloc.add(SudokuHintRequested())).called(1);
      },
    );
  });
}
