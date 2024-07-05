import 'package:flutter/material.dart';

/// {@template sudoku_board_divider}
/// Builds dividers for Sudoku board, and sub-grids.
/// {@endtemplate}
class SudokuBoardDivider extends StatelessWidget {
  /// {@macro sudoku_board_divider}
  const SudokuBoardDivider({
    required this.dimension,
    required this.width,
    super.key,
  });

  /// Dimension of the square where boarder will be painted.
  final double dimension;

  /// Width of the border.
  final double width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox.square(
      dimension: dimension,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: theme.dividerColor,
            width: width,
          ),
        ),
      ),
    );
  }
}
