import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku/colors/colors.dart';
import 'package:sudoku/layout/layout.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/puzzle/puzzle.dart';
import 'package:sudoku/sudoku/sudoku.dart';
// import 'package:sudoku/sudoku/sudoku.dart';
import 'package:sudoku/typography/typography.dart';

/// {@template sudoku_block}
/// Displays the Sudoku [block] based upon the current puzzle [state].
/// {@endtemplate}
class SudokuBlock extends StatelessWidget {
  /// {@macro sudoku_block}
  const SudokuBlock({
    required this.block,
    required this.state,
    super.key,
  });

  /// The [Block] to be displayed.
  final Block block;

  /// The state of the sudoku.
  final PuzzleState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dimension = state.puzzle.sudoku.getDimesion();

    final selectedBlock = context.select(
      (PuzzleBloc bloc) => bloc.state.selectedBlock,
    );
    final highlightedBlocks = context.select(
      (PuzzleBloc bloc) => bloc.state.highlightedBlocks,
    );

    // Comparing with the current block's position, otherwise
    // this will return false result, when the `currentValue` is updated.
    final isBlockSelected = selectedBlock?.position == block.position;

    // Checking with the current block's position, otherwise
    // this will return false when the `currentValue` is updated, hence this
    // block will no longer remain highlighted.
    final isBlockHighlighted = highlightedBlocks
        .map((block) => block.position)
        .contains(block.position);

    return ResponsiveLayoutBuilder(
      small: (_, child) => SizedBox.square(
        dimension: SudokuBoardSize.small / dimension,
        key: Key('sudoku_block_small_${block.position.x}_${block.position.y}'),
        child: child,
      ),
      medium: (_, child) => SizedBox.square(
        dimension: SudokuBoardSize.medium / dimension,
        key: Key('sudoku_block_medium_${block.position.x}_${block.position.y}'),
        child: child,
      ),
      large: (_, child) => SizedBox.square(
        dimension: SudokuBoardSize.large / dimension,
        key: Key('sudoku_block_large_${block.position.x}_${block.position.y}'),
        child: child,
      ),
      child: (_) {
        return GestureDetector(
          onTap: () {
            context.read<PuzzleBloc>().add(SudokuBlockSelected(block));
          },
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: isBlockSelected
                  ? SudokuColors.lightPurple.withOpacity(0.27)
                  : isBlockHighlighted
                      ? theme.splashColor.withOpacity(0.2)
                      : null,
              border: Border.all(
                color: theme.highlightColor,
              ),
            ),
            child: Center(
              child: Text(
                block.currentValue != -1 ? '${block.currentValue}' : '',
                style: SudokuTextStyle.bodyText1.copyWith(
                  color: block.correctValue != block.currentValue
                      ? theme.colorScheme.error
                      : block.isGenerated
                          ? null
                          : theme.brightness == Brightness.light
                              ? SudokuColors.getPurple(context)
                              : SudokuColors.lightPurple.withGreen(224),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
