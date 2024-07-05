// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sudoku/layout/responsive_layout_builder.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/sudoku/sudoku.dart';

import '../../helpers/helpers.dart';

class _MockSudokuBloc extends MockBloc<SudokuEvent, SudokuState>
    implements SudokuBloc {}

class _MockSudoku extends Mock implements Sudoku {}

class _FakeBlock extends Fake implements Block {}

void main() {
  group('SudokuPage', () {
    testWidgets('renders SudokuView', (tester) async {
      await tester.pumpApp(const SudokuPage());
      expect(find.byType(SudokuView), findsOneWidget);
    });
  });

  group('SudokuView', () {
    late SudokuBloc sudokuBloc;
    late Sudoku sudoku;

    setUp(() {
      sudokuBloc = _MockSudokuBloc();
      sudoku = _MockSudoku();
      when(() => sudoku.getDimesion()).thenReturn(3);
      when(() => sudoku.blocks).thenReturn([]);
      when(() => sudokuBloc.state).thenReturn(
        SudokuState(sudoku: sudoku),
      );
    });

    testWidgets('renders appbar in small layout', (tester) async {
      tester.setSmallDisplaySize();
      await tester.pumpApp(
        const SudokuView(),
        sudokuBloc: sudokuBloc,
      );
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('renders appbar in medium layout', (tester) async {
      tester.setMediumDisplaySize();
      await tester.pumpApp(
        const SudokuView(),
        sudokuBloc: sudokuBloc,
      );
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('does not render appbar in large layout', (tester) async {
      tester.setLargeDisplaySize();
      await tester.pumpApp(
        const SudokuView(),
        sudokuBloc: sudokuBloc,
      );
      expect(find.byType(AppBar), findsNothing);
    });
  });

  group('SudokuBoardView', () {
    late SudokuBloc sudokuBloc;
    late Sudoku sudoku;

    setUp(() {
      sudokuBloc = _MockSudokuBloc();
      sudoku = _MockSudoku();
      when(() => sudoku.getDimesion()).thenReturn(3);
      when(() => sudoku.blocks).thenReturn([]);
      when(() => sudokuBloc.state).thenReturn(
        SudokuState(sudoku: sudoku),
      );
    });

    testWidgets(
      're-renders only when sudoku from [SudokuState] changes',
      (tester) async {
        final block1 = Block(
          position: Position(x: 0, y: 0),
          correctValue: 1,
          currentValue: 1,
        );
        final block2 = Block(
          position: Position(x: 0, y: 1),
          correctValue: 2,
          currentValue: 2,
        );

        when(() => sudokuBloc.stream).thenAnswer(
          (_) => Stream.fromIterable([
            SudokuState(sudoku: Sudoku(blocks: const [])),
            SudokuState(sudoku: Sudoku(blocks: [block1, block2])),
          ]),
        );

        await tester.pumpApp(
          const SudokuBoardView(
            layoutSize: ResponsiveLayoutSize.large,
          ),
          sudokuBloc: sudokuBloc,
        );

        await tester.pumpAndSettle();
        expect(find.byKey(Key('sudoku_board_view_0_0')), findsOneWidget);
        expect(find.byKey(Key('sudoku_board_view_0_1')), findsOneWidget);
      },
    );
  });
}
