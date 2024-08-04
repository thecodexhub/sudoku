// ignore_for_file: avoid_redundant_argument_values, prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/home/home.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/puzzle/puzzle.dart';

import '../../helpers/helpers.dart';

void main() {
  group('HomeState', () {
    HomeState createSubject({
      Difficulty? difficulty,
      SudokuCreationStatus? sudokuCreationStatus,
      SudokuCreationErrorType? sudokuCreationError,
      Puzzle? unfinishedPuzzle,
      Player? player,
    }) {
      return HomeState(
        difficulty: difficulty,
        sudokuCreationStatus:
            sudokuCreationStatus ?? SudokuCreationStatus.initial,
        sudokuCreationError: sudokuCreationError,
        unfinishedPuzzle: unfinishedPuzzle,
        player: player ?? Player.empty,
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
            SudokuCreationStatus.initial,
            null,
            null,
            Player.empty,
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
            difficulty: null,
            sudokuCreationStatus: null,
            sudokuCreationError: null,
            unfinishedPuzzle: null,
            player: null,
          ),
          equals(createSubject()),
        );
      });

      test('returns the updated copy of this for every non-null parameter', () {
        final puzzle = MockPuzzle();
        expect(
          createSubject().copyWith(
            difficulty: () => Difficulty.expert,
            sudokuCreationStatus: () => SudokuCreationStatus.inProgress,
            sudokuCreationError: () => SudokuCreationErrorType.unexpected,
            unfinishedPuzzle: () => puzzle,
            player: () => Player(easyAttempted: 5),
          ),
          equals(
            createSubject(
              difficulty: Difficulty.expert,
              sudokuCreationStatus: SudokuCreationStatus.inProgress,
              sudokuCreationError: SudokuCreationErrorType.unexpected,
              unfinishedPuzzle: puzzle,
              player: Player(easyAttempted: 5),
            ),
          ),
        );
      });
    });

    test('can copyWith null parameters', () {
      expect(
        createSubject().copyWith(
          difficulty: () => null,
          sudokuCreationError: () => null,
          unfinishedPuzzle: () => null,
        ),
        equals(
          createSubject(
            difficulty: null,
            sudokuCreationError: null,
            unfinishedPuzzle: null,
          ),
        ),
      );
    });
  });
}
