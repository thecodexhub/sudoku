// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/api/dtos/dtos.dart';
import 'package:sudoku/models/models.dart';

void main() {
  group('CreateSudokuRequestDto', () {
    CreateSudokuRequestDto createSubject({
      CreateSudokuRequest? data,
    }) {
      return CreateSudokuRequestDto(
        data: data ?? CreateSudokuRequest(difficulty: 'easy'),
      );
    }

    test('constructor works correctly', () {
      expect(createSubject, returnsNormally);
    });

    test('props are correct', () {
      expect(
        createSubject().props,
        equals(
          <Object?>[
            CreateSudokuRequest(difficulty: 'easy'),
          ],
        ),
      );
    });

    test('toJson works correctly', () {
      expect(
        createSubject().toJson(),
        equals({
          'data': {
            'difficulty': 'easy',
          },
        }),
      );
    });
  });

  group('CreateSudokuRequest', () {
    CreateSudokuRequest createSubject({
      String? difficulty,
    }) {
      return CreateSudokuRequest(
        difficulty: difficulty ?? Difficulty.easy.name,
      );
    }

    test('constructor works correctly', () {
      expect(createSubject, returnsNormally);
    });

    test('props are correct', () {
      expect(
        createSubject().props,
        equals(<Object?>['easy']),
      );
    });

    test('toJson works correctly', () {
      expect(
        createSubject().toJson(),
        equals({
          'difficulty': 'easy',
        }),
      );
    });

    test('fromJson works correctly', () {
      expect(
        CreateSudokuRequest.fromJson(const {
          'difficulty': 'easy',
        }),
        equals(createSubject()),
      );
    });
  });
}
