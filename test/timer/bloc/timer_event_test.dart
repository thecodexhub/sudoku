// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/timer/timer.dart';

void main() {
  group('TimerEvent', () {
    group('TimerStarted', () {
      test('supports value equality', () {
        expect(TimerStarted(), equals(TimerStarted()));
      });

      test('props are correct', () {
        expect(TimerStarted().props, equals(<Object?>[]));
      });
    });

    group('TimerTicked', () {
      test('supports value equality', () {
        expect(TimerTicked(15), equals(TimerTicked(15)));
      });

      test('props are correct', () {
        expect(
          TimerTicked(15).props,
          equals(<Object?>[15]),
        );
      });
    });

    group('TimerStopped', () {
      test('supports value equality', () {
        expect(TimerStopped(), equals(TimerStopped()));
      });

      test('props are correct', () {
        expect(TimerStopped().props, equals(<Object?>[]));
      });
    });

    group('TimerResumed', () {
      test('supports value equality', () {
        expect(TimerResumed(), equals(TimerResumed()));
      });

      test('props are correct', () {
        expect(TimerResumed().props, equals(<Object?>[]));
      });
    });

    group('TimerReset', () {
      test('supports value equality', () {
        expect(TimerReset(), equals(TimerReset()));
      });

      test('props are correct', () {
        expect(TimerReset().props, equals(<Object?>[]));
      });
    });
  });
}
