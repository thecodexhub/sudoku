// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/puzzle/puzzle.dart';

void main() {
  group('PuzzleState', () {
    PuzzleState createSubject({
      Puzzle? puzzle,
      PuzzleStatus? puzzleStatus,
      HintStatus? hintStatus,
      List<Block>? highlightedBlocks,
      Block? selectedBlock,
      Hint? hint,
    }) {
      return PuzzleState(
        puzzle: puzzle ??
            Puzzle(
              sudoku: Sudoku(blocks: const []),
              difficulty: Difficulty.medium,
            ),
        puzzleStatus: puzzleStatus ?? PuzzleStatus.incomplete,
        hintStatus: hintStatus ?? HintStatus.initial,
        highlightedBlocks: highlightedBlocks ?? [],
        selectedBlock: selectedBlock,
        hint: hint,
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
          PuzzleStatus.incomplete, // puzzleStatus
          HintStatus.initial, // hintStatus
          [], // highlightedBlock
          null, // selectedBlock
          null, // hint
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
            hintStatus: null,
            highlightedBlocks: null,
            selectedBlock: null,
            hint: null,
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
            hintStatus: () => HintStatus.fetchSuccess,
            highlightedBlocks: () => [],
            selectedBlock: () => Block(
              position: Position(x: 0, y: 0),
              correctValue: 4,
              currentValue: -1,
            ),
            hint: () => Hint(
              cell: Position(x: 0, y: 3),
              entry: 6,
              observation: 'observation',
              explanation: 'explanation',
              solution: 'solution',
            ),
          ),
          equals(
            createSubject(
              puzzle: Puzzle(
                sudoku: Sudoku(blocks: const []),
                difficulty: Difficulty.medium,
              ),
              puzzleStatus: PuzzleStatus.failed,
              hintStatus: HintStatus.fetchSuccess,
              highlightedBlocks: [],
              selectedBlock: Block(
                position: Position(x: 0, y: 0),
                correctValue: 4,
                currentValue: -1,
              ),
              hint: Hint(
                cell: Position(x: 0, y: 3),
                entry: 6,
                observation: 'observation',
                explanation: 'explanation',
                solution: 'solution',
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

    group('HintStatus extension', () {
      test('isFetchInProgress getter works correctly', () {
        const hintStatus1 = HintStatus.fetchInProgress;
        const hintStatus2 = HintStatus.fetchFailed;

        expect(hintStatus1.isFetchInProgress, isTrue);
        expect(hintStatus2.isFetchInProgress, isFalse);
      });

      test('isInteractionEnded getter works correctly', () {
        const hintStatus1 = HintStatus.interactionEnded;
        const hintStatus2 = HintStatus.fetchSuccess;

        expect(hintStatus1.isInteractionEnded, isTrue);
        expect(hintStatus2.isInteractionEnded, isFalse);
      });
    });
  });
}
