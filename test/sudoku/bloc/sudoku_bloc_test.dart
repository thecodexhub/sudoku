// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/sudoku/sudoku.dart';

void main() {
  const sudoku2x2Block0 = Block(
    position: Position(x: 0, y: 0),
    correctValue: 4,
    currentValue: -1,
  );

  const sudoku2x2Block1 = Block(
    position: Position(x: 0, y: 1),
    correctValue: 1,
    currentValue: 1,
    isGenerated: true,
  );

  const sudoku2x2Block2 = Block(
    position: Position(x: 0, y: 2),
    correctValue: 2,
    currentValue: -1,
  );

  const sudoku2x2Block3 = Block(
    position: Position(x: 0, y: 3),
    correctValue: 3,
    currentValue: -1,
  );

  const sudoku2x2Block4 = Block(
    position: Position(x: 1, y: 0),
    correctValue: 2,
    currentValue: 2,
    isGenerated: true,
  );

  const sudoku2x2Block5 = Block(
    position: Position(x: 1, y: 1),
    correctValue: 3,
    currentValue: 3,
    isGenerated: true,
  );

  const sudoku2x2Block6 = Block(
    position: Position(x: 1, y: 2),
    correctValue: 4,
    currentValue: -1,
  );

  const sudoku2x2Block7 = Block(
    position: Position(x: 1, y: 3),
    correctValue: 1,
    currentValue: -1,
  );

  const sudoku2x2Block8 = Block(
    position: Position(x: 2, y: 0),
    correctValue: 1,
    currentValue: -1,
  );

  const sudoku2x2Block9 = Block(
    position: Position(x: 2, y: 1),
    correctValue: 4,
    currentValue: -1,
  );

  const sudoku2x2Block10 = Block(
    position: Position(x: 2, y: 2),
    correctValue: 3,
    currentValue: 3,
    isGenerated: true,
  );

  const sudoku2x2Block11 = Block(
    position: Position(x: 2, y: 3),
    correctValue: 2,
    currentValue: 2,
    isGenerated: true,
  );

  const sudoku2x2Block12 = Block(
    position: Position(x: 3, y: 0),
    correctValue: 3,
    currentValue: -1,
  );

  const sudoku2x2Block13 = Block(
    position: Position(x: 3, y: 1),
    correctValue: 2,
    currentValue: -1,
  );

  const sudoku2x2Block14 = Block(
    position: Position(x: 3, y: 2),
    correctValue: 1,
    currentValue: 1,
    isGenerated: true,
  );

  const sudoku2x2Block15 = Block(
    position: Position(x: 3, y: 3),
    correctValue: 4,
    currentValue: -1,
  );

  const sudoku = Sudoku(
    blocks: [
      sudoku2x2Block0,
      sudoku2x2Block1,
      sudoku2x2Block2,
      sudoku2x2Block3,
      sudoku2x2Block4,
      sudoku2x2Block5,
      sudoku2x2Block6,
      sudoku2x2Block7,
      sudoku2x2Block8,
      sudoku2x2Block9,
      sudoku2x2Block10,
      sudoku2x2Block11,
      sudoku2x2Block12,
      sudoku2x2Block13,
      sudoku2x2Block14,
      sudoku2x2Block15,
    ],
  );

  const lastLeftSudokuGenerated = [
    [-1, 1, 2, 3],
    [2, 3, 4, 1],
    [1, 4, 3, 2],
    [3, 2, 1, 4],
  ];

  const lastLeftSudokuAnswer = [
    [4, 1, 2, 3],
    [2, 3, 4, 1],
    [1, 4, 3, 2],
    [3, 2, 1, 4],
  ];

  final lastLeftSudoku = Sudoku.fromRawData(
    lastLeftSudokuGenerated,
    lastLeftSudokuAnswer,
  );

  group('SudokuBlock', () {
    SudokuBloc buildBloc() {
      return SudokuBloc(sudoku: sudoku);
    }

    group('constructor', () {
      test('works correctly', () {
        expect(buildBloc, returnsNormally);
      });

      test('has an initial state', () {
        expect(
          buildBloc().state,
          equals(SudokuState(sudoku: sudoku)),
        );
      });
    });

    group('SudokuBlockSelected', () {
      blocTest<SudokuBloc, SudokuState>(
        'emits state with [cannotBeSelected] [blockSelectionStatus], '
        'and null [selectedBlock] when block [isGenerated] is true',
        build: buildBloc,
        act: (bloc) => bloc.add(SudokuBlockSelected(sudoku2x2Block1)),
        expect: () => [
          SudokuState(
            sudoku: sudoku,
            blockSelectionStatus: BlockSelectionStatus.cannotBeSelected,
            highlightedBlocks: const {},
            currentSelectedBlock: null,
          ),
        ],
      );

      blocTest<SudokuBloc, SudokuState>(
        'emits state with selected [blockSelectionStatus], '
        'and correct [selectedBlock] when block [isGenerated] is false',
        build: buildBloc,
        act: (bloc) => bloc.add(SudokuBlockSelected(sudoku2x2Block0)),
        expect: () => [
          SudokuState(
            sudoku: sudoku,
            blockSelectionStatus: BlockSelectionStatus.selected,
            highlightedBlocks: {
              sudoku2x2Block0,
              sudoku2x2Block1,
              sudoku2x2Block2,
              sudoku2x2Block3,
              sudoku2x2Block4,
              sudoku2x2Block5,
              sudoku2x2Block8,
              sudoku2x2Block12,
            },
            currentSelectedBlock: sudoku2x2Block0,
          ),
        ],
      );
    });

    group('SudokuInputTapped', () {
      final newSudoku = sudoku.updateBlock(sudoku2x2Block0, 7);
      final newLastLeftSudoku = lastLeftSudoku.updateBlock(sudoku2x2Block0, 4);

      blocTest<SudokuBloc, SudokuState>(
        'does not emit state if state [currentSelectedBlock] is emoty',
        build: buildBloc,
        seed: () => SudokuState(sudoku: sudoku, currentSelectedBlock: null),
        act: (bloc) => bloc.add(SudokuInputTapped(7)),
        expect: () => <SudokuState>[],
      );

      blocTest<SudokuBloc, SudokuState>(
        'emits updated sudoku when [isComplete] is false',
        build: buildBloc,
        seed: () => SudokuState(
          sudoku: sudoku,
          blockSelectionStatus: BlockSelectionStatus.selected,
          currentSelectedBlock: sudoku2x2Block0,
        ),
        act: (bloc) => bloc.add(SudokuInputTapped(7)),
        expect: () => [
          SudokuState(
            sudoku: newSudoku,
            blockSelectionStatus: BlockSelectionStatus.selected,
            currentSelectedBlock: sudoku2x2Block0,
          ),
        ],
      );

      blocTest<SudokuBloc, SudokuState>(
        'emits updated sudoku, and puzzle status when [isComplete] '
        'returns true',
        build: buildBloc,
        seed: () => SudokuState(
          sudoku: lastLeftSudoku,
          blockSelectionStatus: BlockSelectionStatus.selected,
          currentSelectedBlock: sudoku2x2Block0,
        ),
        act: (bloc) => bloc.add(SudokuInputTapped(4)),
        expect: () => [
          SudokuState(
            sudoku: newLastLeftSudoku,
            puzzleStatus: SudokuPuzzleStatus.complete,
            blockSelectionStatus: BlockSelectionStatus.selected,
            currentSelectedBlock: sudoku2x2Block0,
          ),
        ],
      );
    });
  });
}
