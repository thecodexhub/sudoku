// A 2 x 2 Sudoku board visualization:
//
//   ┌─────0───────1───────2───────3────► x
//   │  ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐
//   0  │  4  │ │  1  │ │  2  │ │  3  │
//   │  └─────┘ └─────┘ └─────┘ └─────┘
//   │  ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐
//   1  │  2  │ │  3  │ │  4  │ │  1  │
//   │  └─────┘ └─────┘ └─────┘ └─────┘
//   │  ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐
//   2  │  1  │ │  4  │ │  3  │ │  2  │
//   │  └─────┘ └─────┘ └─────┘ └─────┘
//   |  ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐
//   3  │  3  │ │  2  │ │  1  │ │  4  │
//   |  └─────┘ └─────┘ └─────┘ └─────┘
//   ▼
//   y
//
// The puzzle is in completed state (i.e., for above example, each
// column, each row, and each of the four 2 × 2 subgrids that compose
// the grid contain all of the digits from 1 to 4 without repetition).
//
// Every block will have a position, and a correct and current value
// (1-4 on above example).
//
// The correct value is what the value should be in the completed puzzle.
// As seen from the example above, the correct value of block (1, 2) is 4.
// The current value means the value currently set in that specific block.
//
// In ideal scenario, a Sudoku puzzle will be of 3 x 3 dimension.

import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:sudoku/models/models.dart';

/// Error thrown when raw data validation fails during the
/// `generateFromList` operation.
class SudokuInvalidRawDataException implements Exception {
  const SudokuInvalidRawDataException();
}

/// {@template sudoku}
/// Model for a sudoku.
/// {@endtemplate}
class Sudoku extends Equatable {
  /// {@macro sudoku}
  const Sudoku({required this.blocks});

  /// Converts raw data to a [Sudoku] model.
  ///
  /// The `generated` list defines the initial state of the puzzle,
  /// and the `answer` defines the completed state.
  ///
  /// Throws a [SudokuInvalidRawDataException] when validation fails
  /// on raw data. The validation checks for 3 things -
  /// - Whether the generated and asnswer have same number of items.
  /// - Whether each item of the generated data has same length as generated.
  /// - Whether each item of the answer data has same length as answer.
  factory Sudoku.fromRawData(
    List<List<int>> generated,
    List<List<int>> answer,
  ) {
    // Validate the generated and answer list
    final sameLength = generated.length == answer.length;
    final sameItemLengthGenerated = generated.every(
      (item) => item.length == generated.length,
    );
    final sameItemLengthAnswer = answer.every(
      (item) => item.length == answer.length,
    );
    if (!(sameLength && sameItemLengthGenerated && sameItemLengthAnswer)) {
      throw const SudokuInvalidRawDataException();
    }

    // Generate blocks from raw data
    final blocks = <Block>[];
    for (var i = 0; i < generated.length; i++) {
      for (var j = 0; j < generated[i].length; j++) {
        final isEmptyBlock = generated[i][j] == -1;
        final block = Block(
          position: Position(x: i, y: j),
          correctValue: isEmptyBlock ? answer[i][j] : generated[i][j],
          currentValue: generated[i][j],
          isGenerated: !isEmptyBlock,
        );
        blocks.add(block);
      }
    }

    return Sudoku(blocks: blocks);
  }

  /// List of [Block]s representing the current state of the [Sudoku].
  final List<Block> blocks;

  /// Gets the dimension of the [Sudoku], i.e., the number of row or column.
  ///
  /// A 3 x 3 Sudoku will have 81 blocks, and dimesion will be 9.
  int getDimesion() {
    return sqrt(blocks.length).toInt();
  }

  /// Converts the specified sudoku to raw data.
  List<List<int>> toRawData() {
    final dimension = getDimesion();

    final rawData = List<List<int>>.generate(
      dimension,
      (_) => List<int>.generate(dimension, (_) => -1),
    );

    for (final block in blocks) {
      final positionX = block.position.x;
      final positionY = block.position.y;

      rawData[positionX][positionY] = block.currentValue;
    }

    return rawData;
  }

  @override
  List<Object?> get props => [blocks];
}
