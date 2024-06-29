import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/models/models.dart';

void main() {
  group('Sudoku', () {
    const sudoku = Sudoku(
      blocks: [
        Block(
          position: Position(x: 0, y: 0),
          correctValue: 4,
          currentValue: -1,
        ),
        Block(
          position: Position(x: 0, y: 1),
          correctValue: 1,
          currentValue: 1,
          isGenerated: true,
        ),
        Block(
          position: Position(x: 0, y: 2),
          correctValue: 2,
          currentValue: -1,
        ),
        Block(
          position: Position(x: 0, y: 3),
          correctValue: 3,
          currentValue: -1,
        ),
        Block(
          position: Position(x: 1, y: 0),
          correctValue: 2,
          currentValue: 2,
          isGenerated: true,
        ),
        Block(
          position: Position(x: 1, y: 1),
          correctValue: 3,
          currentValue: 3,
          isGenerated: true,
        ),
        Block(
          position: Position(x: 1, y: 2),
          correctValue: 4,
          currentValue: -1,
        ),
        Block(
          position: Position(x: 1, y: 3),
          correctValue: 1,
          currentValue: -1,
        ),
        Block(
          position: Position(x: 2, y: 0),
          correctValue: 1,
          currentValue: -1,
        ),
        Block(
          position: Position(x: 2, y: 1),
          correctValue: 4,
          currentValue: -1,
        ),
        Block(
          position: Position(x: 2, y: 2),
          correctValue: 3,
          currentValue: 3,
          isGenerated: true,
        ),
        Block(
          position: Position(x: 2, y: 3),
          correctValue: 2,
          currentValue: 2,
          isGenerated: true,
        ),
        Block(
          position: Position(x: 3, y: 0),
          correctValue: 3,
          currentValue: -1,
        ),
        Block(
          position: Position(x: 3, y: 1),
          correctValue: 2,
          currentValue: -1,
        ),
        Block(
          position: Position(x: 3, y: 2),
          correctValue: 1,
          currentValue: 1,
          isGenerated: true,
        ),
        Block(
          position: Position(x: 3, y: 3),
          correctValue: 4,
          currentValue: -1,
        ),
      ],
    );

    const generatedRawData = [
      [-1, 1, -1, -1],
      [2, 3, -1, -1],
      [-1, -1, 3, 2],
      [-1, -1, 1, -1],
    ];

    const answerRawData = [
      [4, 1, 2, 3],
      [2, 3, 4, 1],
      [1, 4, 3, 2],
      [3, 2, 1, 4],
    ];

    const invalidGeneratedRawData1 = [
      [-1, 1, -1, -1],
      [2, 3, -1, -1],
      [-1, -1, 3, 2],
    ];

    const invalidGeneratedRawData2 = [
      [-1, 1, -1, -1],
      [2, 3, -1, -1],
      [-1, -1, 3],
      [-1, -1, 1, -1],
    ];

    const invalidAnswerRawData1 = [
      [4, 1, 2],
      [2, 3, 4],
      [1, 4, 3],
      [3, 2, 1],
    ];

    test('props are correct', () {
      expect(sudoku.props, <Object?>[sudoku.blocks]);
    });

    test('getDimension works correctly', () {
      expect(sudoku.getDimesion(), equals(4));
    });

    group('fromRawData', () {
      test('builds correct sudoku object', () {
        expect(
          Sudoku.fromRawData(generatedRawData, answerRawData),
          equals(sudoku),
        );
      });

      test(
        'throws SudokuInvalidRawDataException when generated '
        'and answer length do not match',
        () {
          expect(
            () => Sudoku.fromRawData(invalidGeneratedRawData1, answerRawData),
            throwsA(isA<SudokuInvalidRawDataException>()),
          );
        },
      );

      test(
        'throws SudokuInvalidRawDataException when generated '
        'raw data items do not match length',
        () {
          expect(
            () => Sudoku.fromRawData(invalidGeneratedRawData2, answerRawData),
            throwsA(isA<SudokuInvalidRawDataException>()),
          );
        },
      );

      test(
        'throws SudokuInvalidRawDataException when answer '
        'raw data items do not match length',
        () {
          expect(
            () => Sudoku.fromRawData(generatedRawData, invalidAnswerRawData1),
            throwsA(isA<SudokuInvalidRawDataException>()),
          );
        },
      );
    });

    group('toRawData', () {
      test('converts the current sudoku into correct raw data', () {
        expect(
          sudoku.toRawData(),
          equals(generatedRawData),
        );
      });
    });
  });
}
