import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:sudoku/assets/assets.dart';
import 'package:sudoku/colors/colors.dart';
import 'package:sudoku/l10n/l10n.dart';
import 'package:sudoku/layout/layout.dart';
import 'package:sudoku/typography/typography.dart';

/// {@template sudoku_loading_dialog}
/// Displays a dialog while sudoku creation is in progress.
/// {@endtemplate}
class SudokuLoadingDialog extends StatelessWidget {
  /// {@macro sudoku_loading_dialog}
  const SudokuLoadingDialog({
    required this.difficulty,
    super.key,
  });

  /// The string version of the sudoku difficulty.
  final String difficulty;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    const gradient = LinearGradient(
      colors: [
        SudokuColors.darkPurple,
        SudokuColors.darkPink,
      ],
    );

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 620,
        ),
        child: ResponsiveLayoutBuilder(
          small: (_, child) => Padding(
            key: const Key('sudoku_loading_dialog_small'),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            child: child,
          ),
          medium: (_, child) => Padding(
            key: const Key('sudoku_loading_dialog_medium'),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 28,
            ),
            child: child,
          ),
          large: (_, child) => Padding(
            key: const Key('sudoku_loading_dialog_large'),
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 32,
            ),
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
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      Assets.geminiIcon,
                      height: 24,
                      width: 24,
                    ),
                    const SizedBox(width: 8),
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => gradient.createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                      ),
                      child: Text(
                        l10n.createSudokuDialogTitle,
                        style: SudokuTextStyle.subtitle1.copyWith(
                          fontWeight: SudokuFontWeight.semiBold,
                          fontSize: titleFontSize,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: gap),
                const SizedBox(
                  height: 32,
                  width: 32,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballRotateChase,
                    colors: [
                      SudokuColors.darkPink,
                      SudokuColors.darkPurple,
                    ],
                    strokeWidth: 2,
                  ),
                ),
                SizedBox(height: gap),
                Text(
                  l10n.createSudokuDialogSubtitle(difficulty),
                  textAlign: TextAlign.center,
                  style: SudokuTextStyle.caption.copyWith(
                    fontSize: subtitleFontSize,
                    color: theme.dividerColor,
                    fontWeight: SudokuFontWeight.medium,
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
