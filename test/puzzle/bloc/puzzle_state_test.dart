// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/puzzle/puzzle.dart';

void main() {
  group('PuzzleState', () {
    PuzzleState createSubject({
      Puzzle? puzzle,
      PuzzleStatus? puzzleStatus,
      List<Block>? highlightedBlocks,
      Block? selectedBlock,
    }) {
      return PuzzleState(
        puzzle: puzzle ??
            Puzzle(
              sudoku: Sudoku(blocks: const []),
              difficulty: Difficulty.medium,
            ),
        puzzleStatus: puzzleStatus ?? PuzzleStatus.incomplete,
        highlightedBlocks: highlightedBlocks ?? [],
        selectedBlock: selectedBlock,
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
          Puzzle(
            sudoku: Sudoku(blocks: const []),
            difficulty: Difficulty.medium,
          ),
          PuzzleStatus.incomplete,
          [],
          null,
        ]),
      );
    });

    group('copyWith', () {
      test('returns same object if no argument is passed', () {
        expect(createSubject().copyWith(), equals(createSubject()));
      });

      test('returns the old value for each parameter if null is provided', () {
        expect(
          createSubject().copyWith(
            puzzle: null,
            puzzleStatus: null,
            highlightedBlocks: null,
            selectedBlock: null,
          ),
          equals(createSubject()),
        );
      });

      test('returns the updated copy of this for every non-null parameter', () {
        expect(
          createSubject().copyWith(
            puzzle: () => Puzzle(
              sudoku: Sudoku(blocks: const []),
              difficulty: Difficulty.medium,
            ),
            puzzleStatus: () => PuzzleStatus.failed,
            highlightedBlocks: () => [],
            selectedBlock: () => Block(
              position: Position(x: 0, y: 0),
              correctValue: 4,
              currentValue: -1,
            ),
          ),
          equals(
            createSubject(
              puzzle: Puzzle(
                sudoku: Sudoku(blocks: const []),
                difficulty: Difficulty.medium,
              ),
              puzzleStatus: PuzzleStatus.failed,
              highlightedBlocks: [],
              selectedBlock: Block(
                position: Position(x: 0, y: 0),
                correctValue: 4,
                currentValue: -1,
              ),
            ),
          ),
        );
      });
    });

    test('can copyWith null selectedBlock', () {
      expect(
        createSubject(
          selectedBlock: Block(
            position: Position(x: 0, y: 0),
            correctValue: 4,
            currentValue: -1,
          ),
        ).copyWith(selectedBlock: () => null),
        createSubject(selectedBlock: null),
      );
    });
  });
}
