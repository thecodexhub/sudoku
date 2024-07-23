// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/models/models.dart';

void main() {
  group('Position', () {
    Position createSubject({int x = 0, int y = 0}) {
      return Position(x: x, y: y);
    }

    test('constructor works correctly', () {
      expect(createSubject, returnsNormally);
    });

    test('props are correct', () {
      expect(
        createSubject().props,
        equals(<Object?>[0, 0]),
      );
    });

    group('toJson', () {
      test('works correctly', () {
        final position = createSubject();
        expect(
          position.toJson(),
          equals({
            'x': position.x,
            'y': position.y,
          }),
        );
      });
    });

    group('fromJson', () {
      test('works correctly', () {
        final json = {'x': 0, 'y': 0};
        expect(
          Position.fromJson(json),
          equals(createSubject()),
        );
      });
    });

    group('compareTo', () {
      test('returns -1 when other position y co-ordinate is greater', () {
        expect(
          createSubject().compareTo(Position(x: 0, y: 1)),
          equals(-1),
        );
      });

      test('returns 1 when other position y co-ordinate is lesser', () {
        expect(
          createSubject(y: 2).compareTo(Position(x: 0, y: 1)),
          equals(1),
        );
      });

      test('returns -1 when other position x co-ordinate is greater', () {
        expect(
          createSubject().compareTo(Position(x: 1, y: 0)),
          equals(-1),
        );
      });

      test('returns 1 when other position x co-ordinate is lesser', () {
        expect(
          createSubject(x: 2).compareTo(Position(x: 1, y: 0)),
          equals(1),
        );
      });

      test('returns 0 when other position is same', () {
        expect(
          createSubject(x: 1, y: 2).compareTo(Position(x: 1, y: 2)),
          equals(0),
        );
      });
    });
  });
}
