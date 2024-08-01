import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku/layout/layout.dart';
import 'package:sudoku/puzzle/puzzle.dart';
import 'package:sudoku/sudoku/sudoku.dart';
import 'package:sudoku/typography/typography.dart';
import 'package:sudoku/widgets/widgets.dart';

/// {@template ask_hint_button}
/// Displays a button to ask gemini for hint.
///
/// Disables if the remaining hint count decreases to 0 or
/// a hint request is already in progress.
///
/// {@endtemplate}
// TODO(thecodexhub): Shows a loading indication when loading in progress.
class AskHintButton extends StatelessWidget {
  /// {@macro ask_hint_button}
  const AskHintButton({super.key});

  @override
  Widget build(BuildContext context) {
    final remainingHints = context.select(
      (PuzzleBloc bloc) => bloc.state.puzzle.remainingHints,
    );

    final hintInProgress = context.select(
      (PuzzleBloc bloc) => bloc.state.hintStatus.isFetchInProgress,
    );

    final buttonBeActive = remainingHints > 0 && !hintInProgress;

    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => child!,
      child: (layoutSize) {
        final maxWidth = switch (layoutSize) {
          ResponsiveLayoutSize.small => SudokuBoardSize.small,
          ResponsiveLayoutSize.medium => SudokuBoardSize.medium,
          ResponsiveLayoutSize.large => SudokuInputSize.large * 3,
        };

        return Column(
          children: [
            SizedBox(
              width: maxWidth,
              child: SudokuElevatedButton(
                height: 45,
                buttonText: 'Ask Gemini for a hint',
                onPressed: buttonBeActive
                    ? () => context.read<PuzzleBloc>().add(
                          const SudokuHintRequested(),
                        )
                    : null,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Number of hints remaining: $remainingHints',
              style: SudokuTextStyle.caption,
            ),
          ],
        );
      },
    );
  }
}
