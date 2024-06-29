import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/models/models.dart';

void main() {
  group('Block', () {
    Block createSubject({
      Position position = const Position(x: 2, y: 3),
      int correctValue = 7,
      int currentValue = -1,
    }) {
      return Block(
        position: position,
        correctValue: correctValue,
        currentValue: currentValue,
      );
    }

    test('constructor works correctly', () {
      expect(createSubject, returnsNormally);
    });

    test('props are correct', () {
      expect(
        createSubject().props,
        equals(<Object?>[
          const Position(x: 2, y: 3), // position
          7, // correctValue
          -1, // currentValue
          false, // isGenerated
        ]),
      );
    });

    group('copyWith', () {
      test('updates the current value', () {
        expect(
          createSubject().copyWith(currentValue: 2),
          equals(createSubject(currentValue: 2)),
        );
      });
    });
  });
}
