import 'package:flutter/material.dart';
import 'package:sudoku/colors/colors.dart';
import 'package:sudoku/typography/typography.dart';

/// {@template sudoku_text_button}
/// Custom [TextButton] widget with gradient foreground.
/// {@endtemplate}
class SudokuTextButton extends StatelessWidget {
  /// {@macro sudoku_text_button}
  const SudokuTextButton({
    required this.buttonText,
    required this.onPressed,
    super.key,
  });

  /// Text to be shown in the button.
  final String buttonText;

  /// Triggers the `onPressed` from [TextButton].
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final gradient = LinearGradient(
      colors: [
        SudokuColors.getPurple(context),
        SudokuColors.getPink(context),
      ],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
    );

    return SizedBox(
      height: 26,
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundBuilder: (context, states, child) {
            return ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => gradient.createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              ),
              child: child,
            );
          },
          padding: const EdgeInsets.only(left: 0.1),
          alignment: Alignment.centerLeft,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: SudokuTextStyle.button,
          maxLines: 2,
        ),
      ),
    );
  }
}
