import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/models/models.dart';

void main() {
  group('Sudoku', () {
    const sudoku2x2Block0 = Block(
      position: Position(x: 0, y: 0),
      correctValue: 4,
      currentValue: -1,
    );

    const sudoku2x2Block1 = Block(
      position: Position(x: 0, y: 1),
      correctValue: 1,
      currentValue: 1,
      isGenerated: true,
    );

    const sudoku2x2Block2 = Block(
      position: Position(x: 0, y: 2),
      correctValue: 2,
      currentValue: -1,
    );

    const sudoku2x2Block3 = Block(
      position: Position(x: 0, y: 3),
      correctValue: 3,
      currentValue: -1,
    );

    const sudoku2x2Block4 = Block(
      position: Position(x: 1, y: 0),
      correctValue: 2,
      currentValue: 2,
      isGenerated: true,
    );

    const sudoku2x2Block5 = Block(
      position: Position(x: 1, y: 1),
      correctValue: 3,
      currentValue: 3,
      isGenerated: true,
    );

    const sudoku2x2Block6 = Block(
      position: Position(x: 1, y: 2),
      correctValue: 4,
      currentValue: -1,
    );

    const sudoku2x2Block7 = Block(
      position: Position(x: 1, y: 3),
      correctValue: 1,
      currentValue: -1,
    );

    const sudoku2x2Block8 = Block(
      position: Position(x: 2, y: 0),
      correctValue: 1,
      currentValue: -1,
    );

    const sudoku2x2Block9 = Block(
      position: Position(x: 2, y: 1),
      correctValue: 4,
      currentValue: -1,
    );

    const sudoku2x2Block10 = Block(
      position: Position(x: 2, y: 2),
      correctValue: 3,
      currentValue: 3,
      isGenerated: true,
    );

    const sudoku2x2Block11 = Block(
      position: Position(x: 2, y: 3),
      correctValue: 2,
      currentValue: 2,
      isGenerated: true,
    );

    const sudoku2x2Block12 = Block(
      position: Position(x: 3, y: 0),
      correctValue: 3,
      currentValue: -1,
    );

    const sudoku2x2Block13 = Block(
      position: Position(x: 3, y: 1),
      correctValue: 2,
      currentValue: -1,
    );

    const sudoku2x2Block14 = Block(
      position: Position(x: 3, y: 2),
      correctValue: 1,
      currentValue: 1,
      isGenerated: true,
    );

    const sudoku2x2Block15 = Block(
      position: Position(x: 3, y: 3),
      correctValue: 4,
      currentValue: -1,
    );

    const sudoku = Sudoku(
      blocks: [
        sudoku2x2Block0,
        sudoku2x2Block1,
        sudoku2x2Block2,
        sudoku2x2Block3,
        sudoku2x2Block4,
        sudoku2x2Block5,
        sudoku2x2Block6,
        sudoku2x2Block7,
        sudoku2x2Block8,
        sudoku2x2Block9,
        sudoku2x2Block10,
        sudoku2x2Block11,
        sudoku2x2Block12,
        sudoku2x2Block13,
        sudoku2x2Block14,
        sudoku2x2Block15,
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

    group('toJson', () {
      test('works correctly', () {
        expect(
          sudoku.toJson(),
          equals({
            'blocks': sudoku.blocks.map((b) => b.toJson()).toList(),
          }),
        );
      });
    });

    group('fromJson', () {
      test('works correctly', () {
        expect(
          Sudoku.fromJson({
            'blocks': sudoku.blocks.map((b) => b.toJson()).toList(),
          }),
          equals(sudoku),
        );
      });
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
      test('converts the sudoku into record of puzzle and solution', () {
        final rawData = sudoku.toRawData();
        expect(rawData.$1, equals(generatedRawData));
        expect(rawData.$2, equals(answerRawData));
      });
    });

    group('getSubGridBlocks', () {
      test('returns correct blocks - with block 3', () {
        final subGridBlocks = sudoku.getSubGridBlocks(sudoku2x2Block3);
        expect(
          subGridBlocks,
          equals(
            <Block>[
              sudoku2x2Block2,
              sudoku2x2Block3,
              sudoku2x2Block6,
              sudoku2x2Block7,
            ],
          ),
        );
      });

      test('returns correct blocks - with block 8', () {
        final subGridBlocks = sudoku.getSubGridBlocks(sudoku2x2Block8);
        expect(
          subGridBlocks,
          equals(
            <Block>[
              sudoku2x2Block8,
              sudoku2x2Block9,
              sudoku2x2Block12,
              sudoku2x2Block13,
            ],
          ),
        );
      });

      test('returns correct blocks - with block 15', () {
        final subGridBlocks = sudoku.getSubGridBlocks(sudoku2x2Block15);
        expect(
          subGridBlocks,
          equals(
            <Block>[
              sudoku2x2Block10,
              sudoku2x2Block11,
              sudoku2x2Block14,
              sudoku2x2Block15,
            ],
          ),
        );
      });
    });

    group('getRowBlocks', () {
      test('return correct bocks - with block 0', () {
        final rowBlocks = sudoku.getRowBlocks(sudoku2x2Block0);
        expect(
          rowBlocks,
          equals(
            <Block>[
              sudoku2x2Block0,
              sudoku2x2Block1,
              sudoku2x2Block2,
              sudoku2x2Block3,
            ],
          ),
        );
      });

      test('return correct bocks - with block 10', () {
        final rowBlocks = sudoku.getRowBlocks(sudoku2x2Block10);
        expect(
          rowBlocks,
          equals(
            <Block>[
              sudoku2x2Block8,
              sudoku2x2Block9,
              sudoku2x2Block10,
              sudoku2x2Block11,
            ],
          ),
        );
      });
    });

    group('getColumnBlocks', () {
      test('return correct bocks - with block 1', () {
        final columnBlocks = sudoku.getColumnBlocks(sudoku2x2Block1);
        expect(
          columnBlocks,
          equals(
            <Block>[
              sudoku2x2Block1,
              sudoku2x2Block5,
              sudoku2x2Block9,
              sudoku2x2Block13,
            ],
          ),
        );
      });

      test('return correct bocks - with block 7', () {
        final columnBlocks = sudoku.getColumnBlocks(sudoku2x2Block7);
        expect(
          columnBlocks,
          equals(
            <Block>[
              sudoku2x2Block3,
              sudoku2x2Block7,
              sudoku2x2Block11,
              sudoku2x2Block15,
            ],
          ),
        );
      });
    });

    group('updateBlock', () {
      test('updates the block and returns a new sudoku instance', () {
        final newSudoku = sudoku.updateBlock(sudoku2x2Block8, 1);
        expect(newSudoku.blocks.contains(sudoku2x2Block8), isFalse);

        final indexOfBlock8 = sudoku.blocks.indexOf(sudoku2x2Block8);
        final newBlock8 = newSudoku.blocks[indexOfBlock8];

        expect(
          newBlock8,
          equals(sudoku2x2Block8.copyWith(currentValue: 1)),
        );

        expect(newBlock8.position, equals(sudoku2x2Block8.position));
        expect(newBlock8.currentValue, equals(1));
      });
    });

    group('isComplete', () {
      test('returns false when the sudoku is not yet completed', () {
        expect(sudoku.isComplete(), isFalse);
      });

      test('returns true if the sudoku is completed', () {
        final solvedSudoku = Sudoku.fromRawData(answerRawData, answerRawData);
        expect(solvedSudoku.isComplete(), isTrue);
      });
    });

    group('blocksToHighlight', () {
      test(
        'returns the set of row blocks, column blocks, and sub-grid blocks',
        () {
          const block = sudoku2x2Block8;
          expect(
            sudoku.blocksToHighlight(block),
            equals(
              <Block>{
                ...sudoku.getRowBlocks(block),
                ...sudoku.getColumnBlocks(block),
                ...sudoku.getSubGridBlocks(block),
              }.toList(),
            ),
          );
        },
      );
    });
  });
}
