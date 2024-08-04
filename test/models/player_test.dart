// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/models/models.dart';

void main() {
  group('$Player', () {
    Player createSubject({
      String? name,
      int? easyAttempted,
      int? easySolved,
      int? mediumAttempted,
      int? mediumSolved,
      int? difficultAttempted,
      int? difficultSolved,
      int? expertAttempted,
      int? expertSolved,
      int? totalAttempted,
      int? totalSolved,
    }) {
      return Player(
        name: name ?? '',
        easyAttempted: easyAttempted ?? 0,
        easySolved: easySolved ?? 0,
        mediumAttempted: mediumAttempted ?? 0,
        mediumSolved: mediumSolved ?? 0,
        difficultAttempted: difficultAttempted ?? 0,
        difficultSolved: difficultSolved ?? 0,
        expertAttempted: expertAttempted ?? 0,
        expertSolved: expertSolved ?? 0,
        totalAttempted: totalAttempted ?? 0,
        totalSolved: totalSolved ?? 0,
      );
    }

    test('constructor works correctly', () {
      expect(createSubject, returnsNormally);
    });

    test('props are correct', () {
      expect(
        createSubject().props,
        equals(
          [
            '',
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
          ],
        ),
      );
    });

    test('supports value equality', () {
      expect(createSubject(), equals(createSubject()));
    });

    test('empty returns an empty player object', () {
      expect(Player.empty, equals(createSubject()));
    });

    test('toJson works correctly', () {
      expect(
        createSubject().toJson(),
        equals({
          'name': '',
          'easy_attempted': 0,
          'easy_solved': 0,
          'medium_attempted': 0,
          'medium_solved': 0,
          'difficult_attempted': 0,
          'difficult_solved': 0,
          'expert_attempted': 0,
          'expert_solved': 0,
          'total_attempted': 0,
          'total_solved': 0,
        }),
      );
    });

    test('fromJson works correctly', () {
      expect(
        Player.fromJson({
          'name': '',
          'easy_attempted': 0,
          'easy_solved': 0,
          'medium_attempted': 0,
          'medium_solved': 0,
          'difficult_attempted': 0,
          'difficult_solved': 0,
          'expert_attempted': 0,
          'expert_solved': 0,
          'total_attempted': 0,
          'total_solved': 0,
        }),
        equals(createSubject()),
      );
    });

    group('updateAttemptCount', () {
      test('updates easy attempt count with total attempt', () {
        expect(
          createSubject().updateAttemptCount(Difficulty.easy),
          equals(createSubject(easyAttempted: 1, totalAttempted: 1)),
        );
      });

      test('updates medium attempt count with total attempt', () {
        expect(
          createSubject().updateAttemptCount(Difficulty.medium),
          equals(createSubject(mediumAttempted: 1, totalAttempted: 1)),
        );
      });

      test('updates difficult attempt count with total attempt', () {
        expect(
          createSubject().updateAttemptCount(Difficulty.difficult),
          equals(createSubject(difficultAttempted: 1, totalAttempted: 1)),
        );
      });

      test('updates expert attempt count with total attempt', () {
        expect(
          createSubject().updateAttemptCount(Difficulty.expert),
          equals(createSubject(expertAttempted: 1, totalAttempted: 1)),
        );
      });
    });

    group('updateSolvedCount', () {
      test('updates easy solved count with total solved', () {
        expect(
          createSubject().updateSolvedCount(Difficulty.easy),
          equals(createSubject(easySolved: 1, totalSolved: 1)),
        );
      });

      test('updates medium solved count with total solved', () {
        expect(
          createSubject().updateSolvedCount(Difficulty.medium),
          equals(createSubject(mediumSolved: 1, totalSolved: 1)),
        );
      });

      test('updates difficult solved count with total solved', () {
        expect(
          createSubject().updateSolvedCount(Difficulty.difficult),
          equals(createSubject(difficultSolved: 1, totalSolved: 1)),
        );
      });

      test('updates expert solved count with total solved', () {
        expect(
          createSubject().updateSolvedCount(Difficulty.expert),
          equals(createSubject(expertSolved: 1, totalSolved: 1)),
        );
      });
    });

    group('copyWith', () {
      test('returns same object if no argument is passed', () {
        expect(createSubject().copyWith(), equals(createSubject()));
      });

      test('returns the old value for each parameter if null is provided', () {
        expect(
          createSubject().copyWith(
            name: null,
            easyAttempted: null,
            easySolved: null,
            mediumAttempted: null,
            mediumSolved: null,
            difficultAttempted: null,
            difficultSolved: null,
            expertAttempted: null,
            expertSolved: null,
            totalAttempted: null,
            totalSolved: null,
          ),
          equals(createSubject()),
        );
      });

      test('returns the updated copy of this for every non-null parameter', () {
        expect(
          createSubject().copyWith(
            name: 'test',
            easyAttempted: 1,
            easySolved: 2,
            mediumAttempted: 3,
            mediumSolved: 4,
            difficultAttempted: 5,
            difficultSolved: 6,
            expertAttempted: 7,
            expertSolved: 8,
            totalAttempted: 9,
          ),
          equals(
            createSubject(
              name: 'test',
              easyAttempted: 1,
              easySolved: 2,
              mediumAttempted: 3,
              mediumSolved: 4,
              difficultAttempted: 5,
              difficultSolved: 6,
              expertAttempted: 7,
              expertSolved: 8,
              totalAttempted: 9,
            ),
          ),
        );
      });
    });
  });
}
