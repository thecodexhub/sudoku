import 'package:flutter/material.dart';
import 'package:sudoku/colors/colors.dart';
import 'package:sudoku/layout/layout.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/typography/typography.dart';
import 'package:sudoku/utilities/utilities.dart';
import 'package:sudoku/widgets/widgets.dart';

class CongratsDialog extends StatelessWidget {
  const CongratsDialog({
    required this.difficulty,
    required this.timeInSeconds,
    super.key,
  });

  final Difficulty difficulty;
  final int timeInSeconds;

  @override
  Widget build(BuildContext context) {
    const gradient = LinearGradient(
      colors: [
        SudokuColors.darkPurple,
        SudokuColors.darkPink,
      ],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
    );

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
            key: const Key('congrats_dialog_small'),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: child,
          ),
          medium: (_, child) => Padding(
            key: const Key('congrats_dialog_medium'),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
            child: child,
          ),
          large: (_, child) => Padding(
            key: const Key('congrats_dialog_large'),
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
                ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) => gradient.createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
                  child: Text(
                    'Congratulations!!!',
                    style: SudokuTextStyle.bodyText1.copyWith(
                      fontWeight: SudokuFontWeight.semiBold,
                      fontSize: titleFontSize,
                    ),
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
                      const TextSpan(
                        text: 'You have finished ',
                      ),
                      TextSpan(
                        text: '${difficulty.article} ${difficulty.name}',
                        style: SudokuTextStyle.caption.copyWith(
                          fontWeight: SudokuFontWeight.medium,
                          fontSize: subtitleFontSize,
                          color: difficulty.color,
                        ),
                      ),
                      const TextSpan(
                        text: ' level sudoku in ',
                      ),
                      TextSpan(
                        text: timeInSeconds.format,
                        style: SudokuTextStyle.caption.copyWith(
                          fontWeight: SudokuFontWeight.semiBold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: gap),
                Text(
                  'Thank you for playing the sudoku puzzle!',
                  textAlign: TextAlign.center,
                  style: SudokuTextStyle.caption.copyWith(
                    fontWeight: SudokuFontWeight.medium,
                    fontSize: subtitleFontSize,
                  ),
                ),
                SizedBox(height: gap),
                SudokuElevatedButton(
                  buttonText: 'Return to Home Page',
                  onPressed: () => Navigator.of(context).popUntil(
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