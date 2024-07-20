// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sudoku/puzzle/puzzle.dart';
import 'package:sudoku/sudoku/sudoku.dart';

import '../../helpers/helpers.dart';

void main() {
  group('SudokuInput', () {
    const largeInputKey = 'sudoku_input_large';
    const mediumInputKey = 'sudoku_input_medium';
    const smallInputKey = 'sudoku_input_small';

    late PuzzleBloc puzzleBloc;

    setUp(() {
      puzzleBloc = MockPuzzleBloc();
    });

    testWidgets(
      'adds [SudokuInputEntered] when tapped on an input block',
      (tester) async {
        await tester.pumpApp(
          SudokuInput(sudokuDimension: 1),
          puzzleBloc: puzzleBloc,
        );

        await tester.tap(find.byType(GestureDetector).first);
        await tester.pumpAndSettle();

        verify(() => puzzleBloc.add(SudokuInputEntered(1))).called(1);
      },
    );

    testWidgets(
      'adds [SudokuInputErased] when tapped on the last input block',
      (tester) async {
        await tester.pumpApp(
          SudokuInput(sudokuDimension: 1),
          puzzleBloc: puzzleBloc,
        );

        await tester.tap(find.byType(GestureDetector).last);
        await tester.pumpAndSettle();

        verify(() => puzzleBloc.add(SudokuInputErased())).called(1);
      },
    );

    testWidgets('renders large input on large display', (tester) async {
      tester.setLargeDisplaySize();
      await tester.pumpApp(
        SudokuInput(sudokuDimension: 3),
      );
      expect(find.byKey(Key(largeInputKey)), findsOneWidget);
    });

    testWidgets('renders medium input on medium display', (tester) async {
      tester.setMediumDisplaySize();
      await tester.pumpApp(
        SudokuInput(sudokuDimension: 3),
      );
      expect(find.byKey(Key(mediumInputKey)), findsOneWidget);
    });

    testWidgets('renders small input on small display', (tester) async {
      tester.setSmallDisplaySize();
      await tester.pumpApp(
        SudokuInput(sudokuDimension: 3),
      );
      expect(find.byKey(Key(smallInputKey)), findsOneWidget);
    });
  });
}
