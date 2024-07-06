// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/timer/timer.dart';

void main() {
  group('TimerState', () {
    TimerState createSubject({
      bool isRunning = true,
      int secondsElapsed = 10,
    }) {
      return TimerState(
        isRunning: isRunning,
        secondsElapsed: secondsElapsed,
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
        equals(<Object?>[true, 10]),
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
            isRunning: null,
            secondsElapsed: null,
          ),
          equals(createSubject()),
        );
      });

      test('returns the updated copy of this for every non-null parameter', () {
        expect(
          createSubject().copyWith(
            isRunning: false,
            secondsElapsed: 5,
          ),
          equals(
            createSubject(
              isRunning: false,
              secondsElapsed: 5,
            ),
          ),
        );
      });
    });
  });
}
