// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/sudoku/sudoku.dart';

void main() {
  const rawData = [
    [4, 1, 2, 3],
    [2, 3, 4, 1],
    [1, 4, 3, 2],
    [3, 2, 1, 4],
  ];

  const dummyBlock1 = Block(
    position: Position(x: 1, y: 2),
    correctValue: 1,
    currentValue: 1,
  );

  const dummyBlock2 = Block(
    position: Position(x: 2, y: 1),
    correctValue: 7,
    currentValue: 7,
  );

  group('SudokuState', () {
    SudokuState createSubject({
      Sudoku? sudoku,
      SudokuPuzzleStatus? puzzleStatus,
      BlockSelectionStatus? blockSelectionStatus,
      Set<Block>? highlightedBlocks,
      Block? currentSelectedBlock,
    }) {
      return SudokuState(
        sudoku: sudoku ?? const Sudoku(blocks: []),
        puzzleStatus: puzzleStatus ?? SudokuPuzzleStatus.incomplete,
        blockSelectionStatus:
            blockSelectionStatus ?? BlockSelectionStatus.nothingSelected,
        highlightedBlocks: highlightedBlocks ?? {},
        currentSelectedBlock: currentSelectedBlock,
      );
    }

    test('constructor works correctly', () {
      expect(createSubject, returnsNormally);
    });

    test('supports value equality', () {
      expect(createSubject(), equals(createSubject()));
    });

    test('props are correct', () {
      expect(
        createSubject().props,
        equals(<Object?>[
          const Sudoku(blocks: []), // sudoku
          SudokuPuzzleStatus.incomplete, // puzzleStatus
          BlockSelectionStatus.nothingSelected, // blockSelectionStatus
          <Block>{}, //highlightedBlocks
          null, // currentSelectedBlock
        ]),
      );
    });

    group('copyWith', () {
      test('returns same object if no argument is passed', () {
        expect(
          createSubject().copyWith(),
          equals(createSubject()),
        );
      });

      test('returns the old value for each parameter if null is provided', () {
        expect(
          createSubject().copyWith(
            sudoku: null,
            puzzleStatus: null,
            blockSelectionStatus: null,
            highlightedBlocks: null,
            currentSelectedBlock: null,
          ),
          equals(createSubject()),
        );
      });

      test('returns the updated copy of this for every non-null parameter', () {
        expect(
          createSubject().copyWith(
            sudoku: () => Sudoku.fromRawData(rawData, rawData),
            puzzleStatus: () => SudokuPuzzleStatus.complete,
            blockSelectionStatus: () => BlockSelectionStatus.selected,
            highlightedBlocks: () => {dummyBlock1, dummyBlock2},
            currentSelectedBlock: () => dummyBlock1,
          ),
          equals(
            createSubject(
              sudoku: Sudoku.fromRawData(rawData, rawData),
              puzzleStatus: SudokuPuzzleStatus.complete,
              blockSelectionStatus: BlockSelectionStatus.selected,
              highlightedBlocks: {dummyBlock1, dummyBlock2},
              currentSelectedBlock: dummyBlock1,
            ),
          ),
        );
      });
    });

    test('can copyWith null currentSelectedBlock', () {
      expect(
        createSubject().copyWith(
          currentSelectedBlock: () => null,
        ),
        equals(createSubject(currentSelectedBlock: null)),
      );
    });
  });
}
