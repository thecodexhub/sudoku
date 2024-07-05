// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sudoku/sudoku/sudoku.dart';

import '../../helpers/helpers.dart';

void main() {
  group('SudokuInput', () {
    const largeInputKey = 'sudoku_input_large';
    const mediumInputKey = 'sudoku_input_medium';
    const smallInputKey = 'sudoku_input_small';

    late SudokuBloc sudokuBloc;

    setUp(() {
      sudokuBloc = MockSudokuBloc();
    });

    testWidgets(
      'adds [SudokuInputTapped] when tapped on an input block',
      (tester) async {
        await tester.pumpApp(
          SudokuInput(sudokuDimension: 1),
          sudokuBloc: sudokuBloc,
        );

        await tester.tap(find.byType(GestureDetector));
        await tester.pumpAndSettle();

        verify(() => sudokuBloc.add(SudokuInputTapped(1))).called(1);
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
