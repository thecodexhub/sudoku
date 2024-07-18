// ignore_for_file: avoid_redundant_argument_values, prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/home/home.dart';
import 'package:sudoku/models/models.dart';

void main() {
  group('HomeState', () {
    HomeState createSubject({
      Sudoku? sudoku,
      Difficulty? difficulty,
      SudokuCreationStatus? sudokuCreationStatus,
      SudokuCreationErrorType? sudokuCreationError,
    }) {
      return HomeState(
        sudoku: sudoku,
        difficulty: difficulty,
        sudokuCreationStatus:
            sudokuCreationStatus ?? SudokuCreationStatus.initial,
        sudokuCreationError: sudokuCreationError,
      );
    }

    test('constructor works correctly', () {
      expect(createSubject, returnsNormally);
    });

    test('props are correct', () {
      expect(
        createSubject().props,
        equals(
          <Object?>[
            null,
            null,
            SudokuCreationStatus.initial,
            null,
          ],
        ),
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
            sudokuCreationStatus: null,
            sudokuCreationError: null,
          ),
          equals(createSubject()),
        );
      });

      test('returns the updated copy of this for every non-null parameter', () {
        expect(
          createSubject().copyWith(
            sudoku: () => Sudoku(blocks: const []),
            difficulty: () => Difficulty.expert,
            sudokuCreationStatus: () => SudokuCreationStatus.inProgress,
            sudokuCreationError: () => SudokuCreationErrorType.unexpected,
          ),
          equals(
            createSubject(
              sudoku: Sudoku(blocks: const []),
              difficulty: Difficulty.expert,
              sudokuCreationStatus: SudokuCreationStatus.inProgress,
              sudokuCreationError: SudokuCreationErrorType.unexpected,
            ),
          ),
        );
      });
    });

    test('can copyWith null parameters', () {
      expect(
        createSubject().copyWith(
          sudoku: () => null,
          difficulty: () => null,
          sudokuCreationError: () => null,
        ),
        equals(
          createSubject(
            sudoku: null,
            difficulty: null,
            sudokuCreationError: null,
          ),
        ),
      );
    });
  });
}
