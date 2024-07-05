import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku/layout/layout.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/sudoku/sudoku.dart';
import 'package:sudoku/typography/typography.dart';

/// {@template sudoku_block}
/// Displays the Sudoku [block] based upon the current [state].
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
  final SudokuState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dimension = state.sudoku.getDimesion();

    final selectedBlock = context.select(
      (SudokuBloc bloc) => bloc.state.currentSelectedBlock,
    );
    final highlightedBlocks = context.select(
      (SudokuBloc bloc) => bloc.state.highlightedBlocks,
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
            context.read<SudokuBloc>().add(SudokuBlockSelected(block));
          },
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: isBlockSelected
                  ? theme.primaryColorLight
                  : isBlockHighlighted
                      ? theme.splashColor.withOpacity(0.27)
                      : null,
              border: Border.all(
                color: theme.highlightColor,
              ),
            ),
            child: Center(
              child: Text(
                block.currentValue != -1 ? '${block.currentValue}' : '',
                style: SudokuTextStyle.bodyText1.copyWith(
                  color: block.isGenerated ? null : theme.colorScheme.secondary,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
