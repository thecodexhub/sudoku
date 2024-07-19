// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/puzzle/puzzle.dart';

void main() {
  group('Puzzle', () {
    Puzzle createSubject({
      Sudoku? sudoku,
      Difficulty? difficulty,
      int? totalSecondsElapsed,
      int? remainingMistakes,
      int? remainingHints,
    }) {
      return Puzzle(
        sudoku: sudoku ?? Sudoku(blocks: const []),
        difficulty: difficulty ?? Difficulty.medium,
        totalSecondsElapsed: totalSecondsElapsed ?? 0,
        remainingMistakes: remainingMistakes ?? 2,
        remainingHints: remainingHints ?? 1,
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
          Sudoku(blocks: const []),
          Difficulty.medium,
          0,
          2,
          1,
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
            sudoku: null,
            difficulty: null,
            totalSecondsElapsed: null,
            remainingMistakes: null,
            remainingHints: null,
          ),
          equals(createSubject()),
        );
      });

      test('returns the updated copy of this for every non-null parameter', () {
        expect(
          createSubject().copyWith(
            sudoku: Sudoku(blocks: const []),
            difficulty: Difficulty.expert,
            totalSecondsElapsed: 15,
            remainingMistakes: 1,
            remainingHints: 0,
          ),
          equals(
            createSubject(
              sudoku: Sudoku(blocks: const []),
              difficulty: Difficulty.expert,
              totalSecondsElapsed: 15,
              remainingMistakes: 1,
              remainingHints: 0,
            ),
          ),
        );
      });
    });
  });
}
