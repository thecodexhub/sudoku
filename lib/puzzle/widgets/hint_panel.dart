import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku/colors/colors.dart';
import 'package:sudoku/layout/layout.dart';
import 'package:sudoku/puzzle/puzzle.dart';
import 'package:sudoku/sudoku/sudoku.dart';
import 'package:sudoku/typography/typography.dart';
import 'package:sudoku/widgets/widgets.dart';

/// {@template hint_panel}
/// Widget to display hint. Shows an error message if there was an
/// error in fetching or validating the hint.
/// {@endtemplate}
class HintPanel extends StatelessWidget {
  /// {@macro hint_panel}
  const HintPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final panelBeOpen = context.select(
      (PuzzleBloc bloc) => bloc.state.hintStatus.successOrFailed,
    );

    final hintAvailable = context.select(
      (PuzzleBloc bloc) => bloc.state.hint != null,
    );

    if (!panelBeOpen) {
      return const SizedBox();
    }

    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => child!,
      child: (layoutSize) {
        final maxWidth = switch (layoutSize) {
          ResponsiveLayoutSize.small => SudokuBoardSize.small,
          ResponsiveLayoutSize.medium => SudokuBoardSize.medium,
          ResponsiveLayoutSize.large => 880.0,
        };

        return SizedBox(
          width: maxWidth,
          child: hintAvailable ? const DisplayHint() : const DisplayError(),
        );
      },
    );
  }
}

/// {@template display_hint}
/// Widget to display the hint, when fetch was successful.
/// {@endtemplate}
@visibleForTesting
class DisplayHint extends StatelessWidget {
  /// {@macro display_hint}
  const DisplayHint({super.key});

  @override
  Widget build(BuildContext context) {
    final hint = context.read<PuzzleBloc>().state.hint!;

    final defaulTextStyle = SudokuTextStyle.caption;
    final titleTextStyle = SudokuTextStyle.bodyText2.copyWith(
      fontWeight: SudokuFontWeight.semiBold,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: SudokuColors.lightPurple.withOpacity(0.27),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Observation:', style: titleTextStyle),
            const SizedBox(height: 4),
            Text(hint.observation, style: defaulTextStyle),
            const SizedBox(height: 8),
            Text('Explanation:', style: titleTextStyle),
            const SizedBox(height: 4),
            Text(hint.explanation, style: defaulTextStyle),
            const SizedBox(height: 8),
            Text('Solution:', style: titleTextStyle),
            const SizedBox(height: 4),
            Text(hint.solution, style: defaulTextStyle),
            const SizedBox(height: 8),
            SudokuTextButton(
              buttonText: 'Approve & Close',
              onPressed: () => context.read<PuzzleBloc>().add(
                    const HintInteractioCompleted(),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

/// {@template display_hint}
/// Widget to display the hint, when fetch was successful.
/// {@endtemplate}
@visibleForTesting
class DisplayError extends StatelessWidget {
  /// {@macro display_hint}
  const DisplayError({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: theme.colorScheme.errorContainer.withOpacity(0.45),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              'There has been an error while fetching or validating '
              'the hint. Please try again!',
              textAlign: TextAlign.center,
              style: SudokuTextStyle.caption.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
