import 'package:flutter/material.dart';
import 'package:sudoku/colors/colors.dart';
import 'package:sudoku/l10n/l10n.dart';
import 'package:sudoku/typography/typography.dart';
import 'package:sudoku/utilities/utilities.dart';

/// The url for the Gemini API Competition.
const _competitionUrl = 'https://ai.google.dev/competition';

/// {@template competition_banner}
/// Displays a banner in the Home Page that launches the Gemini
/// API Competition details website.
/// {@endtemplate}
class CompetitionBanner extends StatelessWidget {
  /// {@macro competition_banner}
  const CompetitionBanner({super.key});

  static const gradient = LinearGradient(
    colors: [SudokuColors.darkPurple, SudokuColors.darkPink],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return OutlinedButton(
      onPressed: () => openLink(Uri.parse(_competitionUrl)),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 2.5),
      ),
      child: Text.rich(
        TextSpan(
          children: [
            WidgetSpan(
              child: Text(
                l10n.competitionBannerText,
                style: SudokuTextStyle.caption.copyWith(
                  fontWeight: SudokuFontWeight.medium,
                  fontSize: 12,
                ),
              ),
            ),
            WidgetSpan(
              child: ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => gradient.createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                ),
                child: Text(
                  l10n.competitionBannerCta,
                  style: SudokuTextStyle.caption.copyWith(
                    fontWeight: SudokuFontWeight.semiBold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
