import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku/colors/colors.dart';
import 'package:sudoku/l10n/l10n.dart';
import 'package:sudoku/layout/layout.dart';
import 'package:sudoku/puzzle/puzzle.dart';
import 'package:sudoku/sudoku/sudoku.dart';
import 'package:sudoku/timer/timer.dart';
import 'package:sudoku/typography/typography.dart';

/// {@template sudoku_board}
/// Displays the Sudoku board in a [Stack] containing [blocks].
///
/// When the timer is paused, it shows a paused icon, and not
/// the [blocks] and its values.
/// {@endtemplate}
class SudokuBoard extends StatelessWidget {
  /// {@macro sudoku_board}
  const SudokuBoard({required this.blocks, super.key});

  /// The blocks to be displayed on the Sudoku board.
  final List<Widget> blocks;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final isTimerPaused = context.select(
      (TimerBloc bloc) => !bloc.state.isRunning,
    );

    final isPuzzleOngoing = context.select(
      (PuzzleBloc bloc) => bloc.state.puzzleStatus == PuzzleStatus.incomplete,
    );

    final gradient = LinearGradient(
      colors: [
        SudokuColors.getPurple(context),
        SudokuColors.getPink(context),
      ],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
    );

    return ResponsiveLayoutBuilder(
      small: (_, child) => SizedBox.square(
        key: const Key('sudoku_board_small'),
        dimension: SudokuBoardSize.small,
        child: child,
      ),
      medium: (_, child) => SizedBox.square(
        key: const Key('sudoku_board_medium'),
        dimension: SudokuBoardSize.medium,
        child: child,
      ),
      large: (_, child) => SizedBox.square(
        key: const Key('sudoku_board_large'),
        dimension: SudokuBoardSize.large,
        child: child,
      ),
      child: (currentSize) {
        final boardSize = switch (currentSize) {
          ResponsiveLayoutSize.small => SudokuBoardSize.small,
          ResponsiveLayoutSize.medium => SudokuBoardSize.medium,
          ResponsiveLayoutSize.large => SudokuBoardSize.large,
        };

        final boardDimension = sqrt(blocks.length).toInt();
        final subGridDimension = sqrt(boardDimension).toInt();

        final blockSize = boardSize / boardDimension;
        final subGridSize = subGridDimension * blockSize;
        return Stack(
          children: [
            if (!(isTimerPaused && isPuzzleOngoing)) ...blocks,
            IgnorePointer(
              child: SudokuBoardDivider(
                dimension: boardSize,
                width: 1.4,
              ),
            ),
            for (var i = 0; i < boardDimension; i++)
              Positioned(
                top: (i % subGridDimension) * subGridSize,
                left: (i ~/ subGridDimension) * subGridSize,
                child: IgnorePointer(
                  child: SudokuBoardDivider(
                    dimension: subGridSize,
                    width: 0.8,
                  ),
                ),
              ),
            if (isTimerPaused && isPuzzleOngoing)
              Center(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: FloatingActionButton.extended(
                    backgroundColor: Colors.transparent,
                    onPressed: () => context.read<TimerBloc>().add(
                          const TimerResumed(),
                        ),
                    label: Text(
                      l10n.resumeTimerButtonText,
                      style: SudokuTextStyle.button,
                    ),
                    icon: const Icon(Icons.play_arrow),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
