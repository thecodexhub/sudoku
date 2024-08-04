import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku/assets/assets.dart';
import 'package:sudoku/colors/colors.dart';
import 'package:sudoku/home/home.dart';
import 'package:sudoku/layout/layout.dart';
import 'package:sudoku/typography/typography.dart';
import 'package:sudoku/widgets/widgets.dart';

class PlayerInfoWidget extends StatelessWidget {
  const PlayerInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final player = context.select((HomeBloc bloc) => bloc.state.player);

    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, __) => DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              SudokuColors.darkPurple,
              SudokuColors.darkPink,
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Expanded(
                flex: 2,
                child: SudokuIcon(
                  iconAsset: Assets.dailyChallengeIcon,
                  scaleFactor: 1.8,
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Player Stats',
                      style: SudokuTextStyle.bodyText1.copyWith(
                        fontWeight: SudokuFontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                    ),
                    Text(
                      'Solved / Attempted',
                      style: SudokuTextStyle.bodyText1.copyWith(
                        fontWeight: SudokuFontWeight.medium,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: AttemptedVsSolved(
                            label: 'Easy',
                            attempted: player.easyAttempted,
                            solved: player.easySolved,
                          ),
                        ),
                        const SizedBox(width: 32),
                        Expanded(
                          child: AttemptedVsSolved(
                            label: 'Medium',
                            attempted: player.mediumAttempted,
                            solved: player.mediumSolved,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: AttemptedVsSolved(
                            label: 'Difficult',
                            attempted: player.difficultAttempted,
                            solved: player.difficultSolved,
                          ),
                        ),
                        const SizedBox(width: 32),
                        Expanded(
                          child: AttemptedVsSolved(
                            label: 'Expert',
                            attempted: player.expertAttempted,
                            solved: player.expertSolved,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      large: (_, child) => child!,
      child: (layoutSize) {
        final cardHeight = switch (layoutSize) {
          ResponsiveLayoutSize.small => 252.0,
          ResponsiveLayoutSize.medium => 216.0,
          ResponsiveLayoutSize.large => 472.0,
        };

        final padding = switch (layoutSize) {
          ResponsiveLayoutSize.small => 16.0,
          ResponsiveLayoutSize.medium => 16.0,
          ResponsiveLayoutSize.large => 24.0,
        };

        final titleTextStyle = switch (layoutSize) {
          ResponsiveLayoutSize.small => SudokuTextStyle.bodyText1,
          _ => SudokuTextStyle.headline2,
        };

        final iconScaleFactor = switch (layoutSize) {
          ResponsiveLayoutSize.small => 1.0,
          _ => 1.76,
        };

        return SizedBox(
          height: cardHeight,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  SudokuColors.darkPurple,
                  SudokuColors.darkPink,
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SudokuIcon(
                    iconAsset: Assets.dailyChallengeIcon,
                    scaleFactor: iconScaleFactor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Player Stats',
                    style: titleTextStyle.copyWith(
                      fontWeight: SudokuFontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    'Solved / Attempted',
                    style: titleTextStyle.copyWith(
                      fontWeight: SudokuFontWeight.medium,
                      fontSize: 12,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 8),
                  AttemptedVsSolved(
                    label: 'Easy',
                    attempted: player.easyAttempted,
                    solved: player.easySolved,
                  ),
                  const SizedBox(height: 2),
                  AttemptedVsSolved(
                    label: 'Medium',
                    attempted: player.mediumAttempted,
                    solved: player.mediumSolved,
                  ),
                  const SizedBox(height: 2),
                  AttemptedVsSolved(
                    label: 'Difficult',
                    attempted: player.difficultAttempted,
                    solved: player.difficultSolved,
                  ),
                  const SizedBox(height: 2),
                  AttemptedVsSolved(
                    label: 'Expert',
                    attempted: player.expertAttempted,
                    solved: player.expertSolved,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class AttemptedVsSolved extends StatelessWidget {
  const AttemptedVsSolved({
    required this.label,
    required this.attempted,
    required this.solved,
    super.key,
  });

  final String label;
  final int attempted;
  final int solved;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            label,
            style: SudokuTextStyle.subtitle2.copyWith(
              fontWeight: SudokuFontWeight.semiBold,
              color: Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Flexible(
          child: Text(
            '$solved / $attempted',
            style: SudokuTextStyle.subtitle2.copyWith(
              fontWeight: SudokuFontWeight.semiBold,
              color: Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
