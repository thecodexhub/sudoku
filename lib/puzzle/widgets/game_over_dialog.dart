import 'package:flutter/material.dart';
import 'package:sudoku/l10n/l10n.dart';
import 'package:sudoku/layout/layout.dart';
import 'package:sudoku/typography/typography.dart';
import 'package:sudoku/widgets/widgets.dart';

class GameOverDialog extends StatelessWidget {
  const GameOverDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 440,
        ),
        child: ResponsiveLayoutBuilder(
          small: (_, child) => Padding(
            key: const Key('game_over_dialog_small'),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: child,
          ),
          medium: (_, child) => Padding(
            key: const Key('game_over_dialog_medium'),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
            child: child,
          ),
          large: (_, child) => Padding(
            key: const Key('game_over_dialog_large'),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: child,
          ),
          child: (layoutSize) {
            final gap = switch (layoutSize) {
              ResponsiveLayoutSize.small => 16.0,
              ResponsiveLayoutSize.medium => 18.0,
              ResponsiveLayoutSize.large => 22.0,
            };

            final titleFontSize = switch (layoutSize) {
              ResponsiveLayoutSize.small => 16.0,
              ResponsiveLayoutSize.medium => 18.0,
              ResponsiveLayoutSize.large => 22.0,
            };

            final subtitleFontSize = switch (layoutSize) {
              ResponsiveLayoutSize.small => 12.0,
              ResponsiveLayoutSize.medium => 14.0,
              ResponsiveLayoutSize.large => 16.0,
            };

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.gameOverText,
                  style: SudokuTextStyle.bodyText1.copyWith(
                    fontWeight: SudokuFontWeight.semiBold,
                    fontSize: titleFontSize,
                    color: theme.colorScheme.error,
                  ),
                ),
                SizedBox(height: gap),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: SudokuTextStyle.caption.copyWith(
                      height: 1.4,
                      fontSize: subtitleFontSize,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                    ),
                    children: [
                      TextSpan(
                        text: l10n.gameOverReason1,
                      ),
                      TextSpan(
                        text: l10n.gameOverReason2,
                        style: SudokuTextStyle.caption.copyWith(
                          fontWeight: SudokuFontWeight.medium,
                          fontSize: subtitleFontSize,
                        ),
                      ),
                      TextSpan(
                        text: l10n.gameOverReason3,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: gap),
                Text(
                  l10n.thankYouForPlayingPuzzle,
                  textAlign: TextAlign.center,
                  style: SudokuTextStyle.caption.copyWith(
                    fontWeight: SudokuFontWeight.medium,
                    fontSize: subtitleFontSize,
                  ),
                ),
                SizedBox(height: gap),
                SudokuElevatedButton(
                  buttonText: l10n.returnHomeButtonText,
                  onPressed: () => Navigator.popUntil(
                    context,
                    (route) => route.isFirst,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
