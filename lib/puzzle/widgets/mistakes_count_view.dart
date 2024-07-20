import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku/assets/assets.dart';
import 'package:sudoku/layout/layout.dart';
import 'package:sudoku/puzzle/puzzle.dart';
import 'package:sudoku/typography/typography.dart';

/// {@template mistakes_count_view}
/// Displays how many mistakes are remaining for the current puzzle.
/// {@endtemplate}
class MistakesCountView extends StatelessWidget {
  /// {@macro mistakes_count_view}
  const MistakesCountView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final mistakesCount = context.select(
      (PuzzleBloc bloc) => bloc.state.puzzle.remainingMistakes,
    );

    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => child!,
      child: (layoutSize) {
        final timerTextStyle = switch (layoutSize) {
          ResponsiveLayoutSize.large => SudokuTextStyle.bodyText1,
          _ => SudokuTextStyle.bodyText1,
        };

        return DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: theme.dividerColor,
              width: 1.4,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  Assets.heartIcon,
                  height: timerTextStyle.fontSize,
                  width: timerTextStyle.fontSize,
                ),
                Text(
                  ' x $mistakesCount',
                  style: timerTextStyle,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
