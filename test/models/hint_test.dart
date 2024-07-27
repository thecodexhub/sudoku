// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/models/models.dart';

void main() {
  group('Hint', () {
    Hint createSubject() {
      return Hint(
        cell: Position(x: 0, y: 0),
        entry: 5,
        observation: 'test observation',
        explanation: 'test explanation',
        solution: 'test solution',
      );
    }

    test('constructor works perfectly', () {
      expect(createSubject, returnsNormally);
    });

    test('supports value equality', () {
      expect(createSubject(), equals(createSubject()));
    });

    test('props are correct', () {
      expect(
        createSubject().props,
        equals(<Object?>[
          Position(x: 0, y: 0),
          5,
          'test observation',
          'test explanation',
          'test solution',
        ]),
      );
    });
  });
}
