import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sudoku/l10n/l10n.dart';
import 'package:sudoku/layout/layout.dart';
import 'package:sudoku/typography/typography.dart';

/// {@template sudoku_footer}
/// Displays copyright and licenses for the application.
/// {@endtemplate}
class SudokuFooter extends StatelessWidget {
  /// {@macro sudoku_footer}
  const SudokuFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => child!,
      child: (layoutSize) {
        return Text.rich(
          TextSpan(
            style: SudokuTextStyle.caption,
            children: [
              const WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(Icons.copyright, size: 14),
              ),
              TextSpan(
                text: l10n.copyrightText,
                style: SudokuTextStyle.caption.copyWith(
                  fontWeight: SudokuFontWeight.medium,
                ),
              ),
              TextSpan(
                text: l10n.readLicensesText,
                style: SudokuTextStyle.caption.copyWith(
                  fontWeight: SudokuFontWeight.medium,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => showLicensePage(context: context),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        );
      },
    );
  }
}
