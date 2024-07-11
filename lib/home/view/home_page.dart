import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sudoku/assets/assets.dart';
import 'package:sudoku/l10n/l10n.dart';
import 'package:sudoku/layout/layout.dart';
import 'package:sudoku/typography/typography.dart';
import 'package:sudoku/widgets/widgets.dart';

/// {@template home_page}
/// Displays the Home Page UI.
/// {@endtemplate}
class HomePage extends StatelessWidget {
  /// {@macro home_page}
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: theme.brightness == Brightness.light
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light,
        child: const SudokuBackground(
          child: HomeViewLayout(),
        ),
      ),
    );
  }
}

/// {@template home_view_layout}
/// Builds the layout depending upon the device screen size.
/// {@endtemplate}
@visibleForTesting
class HomeViewLayout extends StatelessWidget {
  /// {@macro home_view_layout}
  const HomeViewLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => Align(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
            maxWidth: SudokuBreakpoint.large,
          ),
          child: Align(child: child),
        ),
      ),
      child: (_) {
        return const SingleChildScrollView(
          child: Column(
            children: [
              ResponsiveGap(
                small: 72,
                medium: 24,
                large: 32,
              ),
              HeaderSection(),
              ResponsiveGap(
                small: 36,
                medium: 48,
                large: 96,
              ),
              ResponsiveHomePageLayout(
                highlightedSection: HighlightedSection(),
                createGameSection: CreateGameSection(),
              ),
              ResponsiveGap(
                small: 36,
                medium: 48,
                large: 96,
              ),
            ],
          ),
        );
      },
    );
  }
}

/// {@template header_section}
/// Header Section of the [HomePage].
///
/// Displays the app title, and subtitle on medium and large screens.
/// {@endtemplate}
@visibleForTesting
class HeaderSection extends StatelessWidget {
  /// {@macro header_section}
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => child!,
      child: (layoutSize) {
        final titleFontStyle = switch (layoutSize) {
          ResponsiveLayoutSize.small => SudokuTextStyle.headline6,
          ResponsiveLayoutSize.medium => SudokuTextStyle.headline5,
          ResponsiveLayoutSize.large => SudokuTextStyle.headline1,
        };

        final subtitleFontStyle = switch (layoutSize) {
          ResponsiveLayoutSize.small => SudokuTextStyle.subtitle2,
          ResponsiveLayoutSize.medium => SudokuTextStyle.subtitle2,
          ResponsiveLayoutSize.large => SudokuTextStyle.subtitle1,
        };

        return Align(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 620,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  Text(
                    l10n.homeAppBarTitle,
                    style: titleFontStyle,
                  ),
                  const ResponsiveGap(
                    small: 12,
                    medium: 12,
                    large: 12,
                  ),
                  Text(
                    l10n.sudokuGameSubtitle,
                    style: subtitleFontStyle.copyWith(
                      color: theme.brightness == Brightness.light
                          ? Colors.black87
                          : Colors.white70,
                    ),
                    textAlign: TextAlign.center,
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

/// {@template responsive_home_page_layout}
/// Layout of the [HomePage] body.
/// {@endtemplate}
@visibleForTesting
class ResponsiveHomePageLayout extends StatelessWidget {
  /// {@macro responsive_home_page_layout}
  const ResponsiveHomePageLayout({
    required this.highlightedSection,
    required this.createGameSection,
    super.key,
  });

  /// Widget to be shown for the daily challenge, and resume
  /// unfinished puzzle.
  final Widget highlightedSection;

  /// Widget to be shown for creating new game of different modes.
  final Widget createGameSection;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, __) => Row(
        children: [
          Expanded(child: highlightedSection),
          Expanded(child: createGameSection),
        ],
      ),
      child: (_) {
        return Column(
          children: [
            highlightedSection,
            const ResponsiveGap(
              small: 24,
              medium: 48,
            ),
            createGameSection,
          ],
        );
      },
    );
  }
}

/// {@template highlighted_secton}
/// Section creating the highlighted items.
///
/// This includes 2 sections - Daily Challenge, and Resume
/// Unfinished Puzzle.
/// {@endtemplate}
@visibleForTesting
class HighlightedSection extends StatelessWidget {
  /// {@macro highlighted_secton}
  const HighlightedSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final dailyChallengeWidget = HighlightedSectionItem(
      key: const Key('daily_challenge_widget'),
      elevatedButtonkey: const Key('daily_challenge_widget_elevated_button'),
      iconAsset: Assets.dailyChallengeIcon,
      title: l10n.dailyChallengeTitle,
      subtitle: l10n.dailyChallengeSubtitle,
      buttonText: 'Play',
      onButtonPressed: () => log('daily_challenge'),
    );

    final resumePuzzleWidget = HighlightedSectionItem(
      key: const Key('resume_puzzle_widget'),
      elevatedButtonkey: const Key('resume_puzzle_widget_elevated_button'),
      iconAsset: Assets.unfinishedPuzzleIcon,
      title: l10n.resumeSudokuTitle,
      subtitle: l10n.resumeSudokuSubtitle,
      buttonText: 'Resume',
      onButtonPressed: null,
    );

    return ResponsiveLayoutBuilder(
      small: (_, __) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Row(
          children: [
            Expanded(child: dailyChallengeWidget),
            const SizedBox(width: 16),
            Expanded(child: resumePuzzleWidget),
          ],
        ),
      ),
      medium: (_, __) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 780,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              dailyChallengeWidget,
              const SizedBox(height: 24),
              resumePuzzleWidget,
            ],
          ),
        ),
      ),
      large: (_, __) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Row(
          children: [
            Expanded(child: dailyChallengeWidget),
            const SizedBox(width: 32),
            Expanded(child: resumePuzzleWidget),
          ],
        ),
      ),
    );
  }
}

/// {@template highlighted_Section_item}
/// Each highlighted item in the [HighlightedSection].
/// {@endtemplate}
@visibleForTesting
class HighlightedSectionItem extends StatelessWidget {
  const HighlightedSectionItem({
    required this.iconAsset,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onButtonPressed,
    this.elevatedButtonkey,
    super.key,
  });

  /// Icon from the assets
  final String iconAsset;

  /// Title for the highlighted item.
  final String title;

  /// Subtitle or caption for the highlighted item.
  final String subtitle;

  /// text to be shown in the button.
  final String buttonText;

  /// Function to be run when the button is pressed.
  final VoidCallback? onButtonPressed;

  /// Key for the [SudokuElevatedButton].
  final Key? elevatedButtonkey;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: theme.dividerColor,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: SudokuIcon(
                  iconAsset: iconAsset,
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
                      title,
                      style: SudokuTextStyle.bodyText1,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subtitle,
                      style: SudokuTextStyle.subtitle2.copyWith(
                        color: theme.brightness == Brightness.light
                            ? Colors.black87
                            : Colors.white70,
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 16),
                    SudokuElevatedButton(
                      key: elevatedButtonkey,
                      buttonText: buttonText,
                      onPressed: onButtonPressed,
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

        final iconScaleFactor = switch (layoutSize) {
          ResponsiveLayoutSize.small => 1.0,
          _ => 1.96,
        };

        final titleTextStyle = switch (layoutSize) {
          ResponsiveLayoutSize.small => SudokuTextStyle.bodyText1,
          _ => SudokuTextStyle.headline2,
        };

        return SizedBox(
          height: cardHeight,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                color: theme.dividerColor,
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
                    iconAsset: iconAsset,
                    scaleFactor: iconScaleFactor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: titleTextStyle.copyWith(
                      fontWeight: SudokuFontWeight.medium,
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: SudokuTextStyle.subtitle2.copyWith(
                      color: theme.brightness == Brightness.light
                          ? Colors.black87
                          : Colors.white70,
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 16),
                  SudokuElevatedButton(
                    key: elevatedButtonkey,
                    buttonText: buttonText,
                    onPressed: onButtonPressed,
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

/// {@template create_game_section}
/// Section creating the new game cards based on modes.
/// {@endtemplate}
@visibleForTesting
class CreateGameSection extends StatelessWidget {
  /// {@macro create_game_section}
  const CreateGameSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final createGameWidgets = [
      CreateGameSectionItem(
        key: const Key('create_game_easy_mode'),
        textButtonkey: const Key('create_game_easy_mode_text_button'),
        iconAsset: Assets.easyPuzzleIcon,
        title: l10n.createEasyGameTitle,
        caption: l10n.createEasyGameCaption,
        onButtonPressed: () => log('easy_mode'),
      ),
      CreateGameSectionItem(
        key: const Key('create_game_medium_mode'),
        textButtonkey: const Key('create_game_medium_mode_text_button'),
        iconAsset: Assets.mediumPuzzleIcon,
        title: l10n.createMediumGameTitle,
        caption: l10n.createMediumGameCaption,
        onButtonPressed: () => log('medium_mode'),
      ),
      CreateGameSectionItem(
        key: const Key('create_game_difficult_mode'),
        textButtonkey: const Key('create_game_difficult_mode_text_button'),
        iconAsset: Assets.difficultPuzzleIcon,
        title: l10n.createDifficultGameTitle,
        caption: l10n.createDifficultGameCaption,
        onButtonPressed: () => log('difficult_mode'),
      ),
      CreateGameSectionItem(
        key: const Key('create_game_expert_mode'),
        textButtonkey: const Key('create_game_expert_mode_text_button'),
        iconAsset: Assets.expertPuzzleIcon,
        title: l10n.createExpertGameTitle,
        caption: l10n.createExpertGameCaption,
        onButtonPressed: () => log('expert_mode'),
      ),
    ];

    return ResponsiveLayoutBuilder(
      small: (_, __) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.createNewGameHeader,
              style: SudokuTextStyle.bodyText1.copyWith(
                fontWeight: SudokuFontWeight.semiBold,
              ),
            ),
            const SizedBox(height: 16),
            for (final widget in createGameWidgets) ...[
              widget,
              const SizedBox(height: 16),
            ],
          ],
        ),
      ),
      medium: (_, child) => child!,
      large: (_, child) => child!,
      child: (layoutSize) {
        final padding = switch (layoutSize) {
          ResponsiveLayoutSize.small => 16.0,
          ResponsiveLayoutSize.medium => 16.0,
          ResponsiveLayoutSize.large => 24.0,
        };

        final maxWidth = switch (layoutSize) {
          ResponsiveLayoutSize.medium => 780.0,
          _ => double.maxFinite,
        };

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxWidth,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (layoutSize == ResponsiveLayoutSize.medium) ...[
                  Text(
                    l10n.createNewGameHeader,
                    style: SudokuTextStyle.headline6,
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: padding + 6),
                ],
                Row(
                  children: [
                    Expanded(child: createGameWidgets[0]),
                    SizedBox(width: padding),
                    Expanded(child: createGameWidgets[1]),
                  ],
                ),
                SizedBox(height: padding),
                Row(
                  children: [
                    Expanded(child: createGameWidgets[2]),
                    SizedBox(width: padding),
                    Expanded(child: createGameWidgets[3]),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// {@template create_game_section_item}
/// Each new game item in the [CreateGameSection].
/// {@endtemplate}
@visibleForTesting
class CreateGameSectionItem extends StatelessWidget {
  /// {@macro create_game_section_item}
  const CreateGameSectionItem({
    required this.iconAsset,
    required this.title,
    required this.caption,
    required this.onButtonPressed,
    this.textButtonkey,
    super.key,
  });

  /// Icon from the assets.
  final String iconAsset;

  /// Title for the create game card.
  final String title;

  /// Caption for the create game card.
  final String caption;

  /// Function to be run when the button is pressed.
  final VoidCallback? onButtonPressed;

  /// Key for the [SudokuTextButton].
  final Key? textButtonkey;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return ResponsiveLayoutBuilder(
      small: (_, __) => DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: theme.dividerColor,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: SudokuIcon(
                  iconAsset: iconAsset,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      style: SudokuTextStyle.bodyText2.copyWith(
                        fontWeight: SudokuFontWeight.semiBold,
                      ),
                      maxLines: 1,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      caption,
                      style: SudokuTextStyle.subtitle2.copyWith(
                        color: theme.brightness == Brightness.light
                            ? Colors.black87
                            : Colors.white70,
                        fontSize: 13,
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 8),
                    SudokuTextButton(
                      key: textButtonkey,
                      buttonText: l10n.buildSudokuBoardButtonText,
                      onPressed: onButtonPressed,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      medium: (_, child) => child!,
      large: (_, child) => child!,
      child: (layoutSize) {
        final cardHeight = switch (layoutSize) {
          ResponsiveLayoutSize.small => null,
          ResponsiveLayoutSize.medium => 212.0,
          ResponsiveLayoutSize.large => 222.0,
        };

        final padding = switch (layoutSize) {
          ResponsiveLayoutSize.small => 16.0,
          ResponsiveLayoutSize.medium => 16.0,
          ResponsiveLayoutSize.large => 24.0,
        };

        return SizedBox(
          height: cardHeight,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                color: theme.dividerColor,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SudokuIcon(iconAsset: iconAsset),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: SudokuTextStyle.bodyText1,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    caption,
                    style: SudokuTextStyle.subtitle2.copyWith(
                      color: theme.brightness == Brightness.light
                          ? Colors.black87
                          : Colors.white70,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 8),
                  SudokuTextButton(
                    key: textButtonkey,
                    buttonText: l10n.buildSudokuBoardButtonText,
                    onPressed: onButtonPressed,
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
