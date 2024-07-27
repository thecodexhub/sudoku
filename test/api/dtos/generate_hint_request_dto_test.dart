// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/api/dtos/dtos.dart';

void main() {
  group('GenerateHintRequestDto', () {
    GenerateHintRequestDto createSubject() {
      return GenerateHintRequestDto(
        data: GenerateHintRequest(
          puzzle: const [
            [1],
            [2],
          ],
          solution: const [
            [2],
            [3],
          ],
        ),
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
        equals(<Object>[
          GenerateHintRequest(
            puzzle: const [
              [1],
              [2],
            ],
            solution: const [
              [2],
              [3],
            ],
          ),
        ]),
      );
    });

    test('toJson works correctly', () {
      expect(
        createSubject().toJson(),
        equals({
          'data': {
            'puzzle': [
              [1],
              [2],
            ],
            'solution': [
              [2],
              [3],
            ],
          },
        }),
      );
    });
  });

  group('GenerateHintRequest', () {
    GenerateHintRequest createSubject() {
      return GenerateHintRequest(
        puzzle: const [
          [1],
          [2],
        ],
        solution: const [
          [2],
          [3],
        ],
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
        equals(<Object>[
          [
            [1],
            [2],
          ],
          [
            [2],
            [3],
          ],
        ]),
      );
    });

    test('fromJson works correctly', () {
      expect(
        GenerateHintRequest.fromJson(const {
          'puzzle': [
            [1],
            [2],
          ],
          'solution': [
            [2],
            [3],
          ],
        }),
        equals(createSubject()),
      );
    });

    test('toJson works correctly', () {
      expect(
        createSubject().toJson(),
        equals({
          'puzzle': [
            [1],
            [2],
          ],
          'solution': [
            [2],
            [3],
          ],
        }),
      );
    });
  });
}
