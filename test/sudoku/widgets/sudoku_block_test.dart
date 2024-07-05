// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/sudoku/sudoku.dart';

import '../../helpers/helpers.dart';

class _MockSudokuBloc extends MockBloc<SudokuEvent, SudokuState>
    implements SudokuBloc {}

class _MockSudokuState extends Mock implements SudokuState {}

class _MockSudoku extends Mock implements Sudoku {}

class _MockBlock extends Mock implements Block {}

void main() {
  group('SudokuBlock', () {
    final block = Block(
      position: Position(x: 0, y: 0),
      correctValue: 1,
      currentValue: 1,
    );

    const smallBlockKey = 'sudoku_block_small_0_0';
    const mediumBlockKey = 'sudoku_block_medium_0_0';
    const largeBlockKey = 'sudoku_block_large_0_0';

    late Sudoku sudoku;
    late SudokuBloc bloc;
    late SudokuState state;

    setUp(() {
      sudoku = _MockSudoku();
      when(() => sudoku.getDimesion()).thenReturn(3);

      state = _MockSudokuState();
      when(() => state.sudoku).thenReturn(sudoku);
      when(() => state.highlightedBlocks).thenReturn({});
      when(() => state.currentSelectedBlock).thenReturn(block);

      bloc = _MockSudokuBloc();
      when(() => bloc.state).thenReturn(state);
    });

    testWidgets(
      'adds [SudokuBlockSelected] when tapped on a block',
      (tester) async {
        await tester.pumpApp(
          SudokuBlock(block: block, state: state),
          sudokuBloc: bloc,
        );

        await tester.tap(find.byType(GestureDetector));
        await tester.pumpAndSettle();

        verify(() => bloc.add(SudokuBlockSelected(block))).called(1);
      },
    );

    testWidgets('renders large block on a large display', (tester) async {
      tester.setLargeDisplaySize();

      await tester.pumpApp(
        SudokuBlock(block: block, state: state),
        sudokuBloc: bloc,
      );

      expect(find.byKey(Key(largeBlockKey)), findsOneWidget);
    });

    testWidgets('renders medium block on a medium display', (tester) async {
      tester.setMediumDisplaySize();

      await tester.pumpApp(
        SudokuBlock(block: block, state: state),
        sudokuBloc: bloc,
      );

      expect(find.byKey(Key(mediumBlockKey)), findsOneWidget);
    });

    testWidgets('renders small block on a small display', (tester) async {
      tester.setSmallDisplaySize();

      await tester.pumpApp(
        SudokuBlock(block: block, state: state),
        sudokuBloc: bloc,
      );

      expect(find.byKey(Key(smallBlockKey)), findsOneWidget);
    });

    testWidgets(
      'renders block when block is part of highlighted, but not selcted',
      (tester) async {
        final otherBlock = _MockBlock();
        when(() => otherBlock.position).thenReturn(Position(x: 0, y: 1));

        when(() => state.highlightedBlocks).thenReturn({block});
        when(() => state.currentSelectedBlock).thenReturn(otherBlock);

        await tester.pumpApp(
          SudokuBlock(
            block: block,
            state: state,
          ),
          sudokuBloc: bloc,
        );

        expect(
          find.byWidgetPredicate((widget) => widget is DecoratedBox),
          findsOneWidget,
        );
      },
    );
  });
}
