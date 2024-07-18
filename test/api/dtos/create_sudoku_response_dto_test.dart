import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/api/dtos/dtos.dart';

void main() {
  group('CreateSudokuResponseDto', () {
    CreateSudokuResponseDto createSubject({
      CreateSudokuResponse? result,
    }) {
      return CreateSudokuResponseDto(
        result: result ??
            const CreateSudokuResponse(
              puzzle: [
                [1],
              ],
              solution: [
                [1],
              ],
            ),
      );
    }

    test('constructor works correctly', () {
      expect(createSubject, returnsNormally);
    });

    test('props are correct', () {
      expect(
        createSubject().props,
        equals(<Object?>[
          const CreateSudokuResponse(
            puzzle: [
              [1],
            ],
            solution: [
              [1],
            ],
          ),
        ]),
      );
    });

    test('fromJson works correctly', () {
      expect(
        CreateSudokuResponseDto.fromJson(const {
          'result': {
            'puzzle': [
              [1],
            ],
            'solution': [
              [1],
            ],
          },
        }),
        equals(createSubject()),
      );
    });
  });

  group('CreateSudokuResponse', () {
    CreateSudokuResponse createSubject({
      List<List<int>>? puzzle,
      List<List<int>>? solution,
    }) {
      return CreateSudokuResponse(
        puzzle: puzzle ??
            [
              [1],
            ],
        solution: solution ??
            [
              [1],
            ],
      );
    }

    test('constructor works correctly', () {
      expect(createSubject, returnsNormally);
    });

    test('props are correct', () {
      expect(
        createSubject().props,
        equals(<Object?>[
          [
            [1],
          ],
          [
            [1],
          ],
        ]),
      );
    });

    test('fromJson works correctly', () {
      expect(
        CreateSudokuResponse.fromJson(const {
          'puzzle': [
            [1],
          ],
          'solution': [
            [1],
          ],
        }),
        equals(createSubject()),
      );
    });
  });
}
