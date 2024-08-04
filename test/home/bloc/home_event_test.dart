// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/home/home.dart';
import 'package:sudoku/models/models.dart';

void main() {
  group('HomeEvent', () {
    group('SudokuCreationRequested', () {
      test('supports value equality', () {
        expect(
          SudokuCreationRequested(Difficulty.medium),
          equals(SudokuCreationRequested(Difficulty.medium)),
        );
      });

      test('props are correct', () {
        expect(
          SudokuCreationRequested(Difficulty.medium).props,
          equals(<Object?>[Difficulty.medium]),
        );
      });
    });

    group('UnfinishedPuzzleSubscriptionRequested', () {
      test('supports value equality', () {
        expect(
          UnfinishedPuzzleSubscriptionRequested(),
          equals(UnfinishedPuzzleSubscriptionRequested()),
        );
      });

      test('props are correct', () {
        expect(
          UnfinishedPuzzleSubscriptionRequested().props,
          equals(<Object?>[]),
        );
      });
    });

    group('UnfinishedPuzzleResumed', () {
      test('supports value equality', () {
        expect(
          UnfinishedPuzzleResumed(),
          equals(UnfinishedPuzzleResumed()),
        );
      });

      test('props are correct', () {
        expect(
          UnfinishedPuzzleResumed().props,
          equals(<Object?>[]),
        );
      });
    });

    group('PlayerSubscriptionRequested', () {
      test('supports value equality', () {
        expect(
          PlayerSubscriptionRequested(),
          equals(PlayerSubscriptionRequested()),
        );
      });

      test('props are correct', () {
        expect(
          PlayerSubscriptionRequested().props,
          equals(<Object?>[]),
        );
      });
    });

    group('NewPuzzleAttempted', () {
      test('supports value equality', () {
        expect(
          NewPuzzleAttempted(Difficulty.easy),
          equals(NewPuzzleAttempted(Difficulty.easy)),
        );
      });

      test('props are correct', () {
        expect(
          NewPuzzleAttempted(Difficulty.easy).props,
          equals(<Object?>[Difficulty.easy]),
        );
      });
    });
  });
}
