// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/api/dtos/dtos.dart';
import 'package:sudoku/models/models.dart';

void main() {
  group('GenerateHintResponseDto', () {
    GenerateHintResponseDto createSubject() {
      return GenerateHintResponseDto(
        result: GenerateHintResponse(
          cell: const [0, 1],
          entry: 5,
          observation: 'test observation',
          explanation: 'test explanation',
          solution: 'test solution',
        ),
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
        equals([
          GenerateHintResponse(
            cell: const [0, 1],
            entry: 5,
            observation: 'test observation',
            explanation: 'test explanation',
            solution: 'test solution',
          ),
        ]),
      );
    });

    test('fromJson works as expected', () {
      expect(
        GenerateHintResponseDto.fromJson(const {
          'result': {
            'cell': [0, 1],
            'entry': 5,
            'observation': 'test observation',
            'explanation': 'test explanation',
            'solution': 'test solution',
          },
        }),
        equals(createSubject()),
      );
    });
  });

  group('GenerateHintResponse', () {
    GenerateHintResponse createSubject() {
      return GenerateHintResponse(
        cell: const [0, 1],
        entry: 5,
        observation: 'test observation',
        explanation: 'test explanation',
        solution: 'test solution',
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
        equals([
          [0, 1],
          5,
          'test observation',
          'test explanation',
          'test solution',
        ]),
      );
    });

    test('fromJson works as expected', () {
      expect(
        GenerateHintResponse.fromJson(
          const {
            'cell': [0, 1],
            'entry': 5,
            'observation': 'test observation',
            'explanation': 'test explanation',
            'solution': 'test solution',
          },
        ),
        equals(createSubject()),
      );
    });

    test('toHint converts to hint object', () {
      expect(
        createSubject().toHint(),
        equals(
          Hint(
            cell: Position(x: 0, y: 1),
            entry: 5,
            observation: 'test observation',
            explanation: 'test explanation',
            solution: 'test solution',
          ),
        ),
      );
    });
  });
}
