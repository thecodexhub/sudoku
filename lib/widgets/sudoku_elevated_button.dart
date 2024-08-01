import 'package:flutter/material.dart';
import 'package:sudoku/colors/colors.dart';
import 'package:sudoku/typography/typography.dart';

/// {@template sudoku_elevated_button}
/// Custom [ElevatedButton] widget with gradient background.
/// {@endtemplate}
class SudokuElevatedButton extends StatelessWidget {
  /// {@macro sudoku_elevated_button}
  const SudokuElevatedButton({
    required this.buttonText,
    required this.onPressed,
    this.height = 36,
    super.key,
  });

  /// The height of the elevated button. Defaults to 36.
  final double height;

  /// Text to be shown in the button.
  final String buttonText;

  /// Triggers the `onPressed` from [ElevatedButton].
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundBuilder: (context, states, child) {
            if (states.contains(WidgetState.disabled)) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: theme.disabledColor.withOpacity(0.1),
                ),
                child: child,
              );
            }

            return DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    SudokuColors.darkPurple,
                    SudokuColors.darkPink,
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
              child: child,
            );
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: SudokuTextStyle.button,
        ),
      ),
    );
  }
}
