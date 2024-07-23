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

    group('toJson', () {
      test('works correctly', () {
        final block = createSubject();
        expect(
          createSubject().toJson(),
          equals({
            'position': {
              'x': block.position.x,
              'y': block.position.y,
            },
            'correctValue': block.correctValue,
            'currentValue': block.currentValue,
            'isGenerated': block.isGenerated,
          }),
        );
      });
    });

    group('fromJson', () {
      test('works correctly', () {
        expect(
          Block.fromJson({
            'position': {
              'x': 2,
              'y': 3,
            },
            'correctValue': 7,
            'currentValue': -1,
            'isGenerated': false,
          }),
          equals(createSubject()),
        );
      });
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
