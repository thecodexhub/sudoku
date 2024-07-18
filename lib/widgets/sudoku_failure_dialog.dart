import 'package:flutter/material.dart';
import 'package:sudoku/home/home.dart';
import 'package:sudoku/l10n/l10n.dart';
import 'package:sudoku/layout/layout.dart';
import 'package:sudoku/typography/typography.dart';

/// {@template sudoku_failure_dialog}
/// Displays a dialog while sudoku creation is in progress.
/// {@endtemplate}
class SudokuFailureDialog extends StatelessWidget {
  /// {@macro sudoku_failure_dialog}
  const SudokuFailureDialog({
    required this.errorType,
    super.key,
  });

  /// Defines the sudoku creation error type.
  final SudokuCreationErrorType errorType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    final errorDescription = switch (errorType) {
      SudokuCreationErrorType.invalidRawData =>
        l10n.errorWrongDataDialogSubtitle,
      _ => l10n.errorClientDialogSubtitle,
    };

    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 440,
      ),
      child: Dialog(
        child: ResponsiveLayoutBuilder(
          small: (_, child) => Padding(
            key: const Key('sudoku_failure_dialog_small'),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            child: child,
          ),
          medium: (_, child) => Padding(
            key: const Key('sudoku_failure_dialog_medium'),
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 32,
            ),
            child: child,
          ),
          large: (_, child) => Padding(
            key: const Key('sudoku_failure_dialog_large'),
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 48,
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
                Text(
                  l10n.errorDialogTitle,
                  style: SudokuTextStyle.subtitle1.copyWith(
                    fontWeight: SudokuFontWeight.semiBold,
                    fontSize: titleFontSize,
                    color: theme.colorScheme.error,
                  ),
                ),
                SizedBox(height: gap),
                Text(
                  errorDescription,
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
