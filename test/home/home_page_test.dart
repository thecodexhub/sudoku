// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/home/home.dart';
import 'package:sudoku/widgets/widgets.dart';

import '../helpers/helpers.dart';

void main() {
  group('HomePage', () {
    const dailyChallengeKey = Key('daily_challenge_widget');
    const resumePuzzleKey = Key('resume_puzzle_widget');

    const dailyChallengeElevatedButtonKey = Key(
      'daily_challenge_widget_elevated_button',
    );
    const resumePuzzleElevatedButtonKey = Key(
      'resume_puzzle_widget_elevated_button',
    );

    testWidgets('renders on a large layout', (tester) async {
      tester.setLargeDisplaySize();
      await tester.pumpApp(HomePage());

      expect(find.byType(HomeView), findsOneWidget);
    });

    testWidgets('renders on a medium layout', (tester) async {
      tester.setMediumDisplaySize();
      await tester.pumpApp(HomePage());

      expect(find.byType(HomeView), findsOneWidget);
    });

    testWidgets('renders on a small layout', (tester) async {
      tester.setSmallDisplaySize();
      await tester.pumpApp(HomePage());

      expect(find.byType(HomeView), findsOneWidget);
    });

    group('Daily Challenge', () {
      testWidgets('exists in the widget tree', (tester) async {
        await tester.pumpApp(HomeView());
        expect(find.byKey(dailyChallengeKey), findsOneWidget);
      });

      testWidgets('onPressed is defined', (tester) async {
        await tester.pumpApp(HomeView());
        final finder = find.byWidgetPredicate(
          (widget) =>
              widget is SudokuElevatedButton &&
              widget.key == dailyChallengeElevatedButtonKey &&
              widget.onPressed != null,
        );
        expect(
          finder,
          findsOneWidget,
        );
        await tester.tap(finder);
        await tester.pumpAndSettle();
      });
    });

    group('Resume Puzzle', () {
      testWidgets('exists in the widget tree', (tester) async {
        await tester.pumpApp(HomeView());
        expect(find.byKey(resumePuzzleKey), findsOneWidget);
      });

      testWidgets('onPressed is defined', (tester) async {
        await tester.pumpApp(HomeView());
        final finder = find.byWidgetPredicate(
          (widget) =>
              widget is SudokuElevatedButton &&
              widget.key == resumePuzzleElevatedButtonKey &&
              widget.onPressed == null,
        );
        expect(
          finder,
          findsOneWidget,
        );
      });
    });

    group('Create Game', () {
      const easyGameKey = Key('create_game_easy_mode');
      const mediumGameKey = Key('create_game_medium_mode');
      const difficultGameKey = Key('create_game_difficult_mode');
      const expertyGameKey = Key('create_game_expert_mode');

      const easyGameTextButtonKey = Key(
        'create_game_easy_mode_text_button',
      );
      const mediumGameTextButtonKey = Key(
        'create_game_medium_mode_text_button',
      );
      const difficultGameTextButtonKey = Key(
        'create_game_difficult_mode_text_button',
      );
      const expertGameTextButtonKey = Key(
        'create_game_expert_mode_text_button',
      );

      group('easy mode', () {
        testWidgets('exists in the widget tree', (tester) async {
          await tester.pumpApp(HomeView());
          expect(find.byKey(easyGameKey), findsOneWidget);
        });

        testWidgets('onPressed is defined', (tester) async {
          // To avoid the below warning:
          // Maybe the widget is actually off-screen, or another widget is
          // obscuring it, or the widget cannot receive pointer events
          tester.setLargeDisplaySize();

          await tester.pumpApp(HomeView());
          final finder = find.byWidgetPredicate(
            (widget) =>
                widget is SudokuTextButton &&
                widget.key == easyGameTextButtonKey &&
                widget.onPressed != null,
          );
          expect(
            finder,
            findsOneWidget,
          );
          await tester.tap(finder);
          await tester.pumpAndSettle();
        });
      });

      group('medium mode', () {
        testWidgets('exists in the widget tree', (tester) async {
          await tester.pumpApp(HomeView());
          expect(find.byKey(mediumGameKey), findsOneWidget);
        });

        testWidgets('onPressed is defined', (tester) async {
          // To avoid the below warning:
          // Maybe the widget is actually off-screen, or another widget is
          // obscuring it, or the widget cannot receive pointer events
          tester.setLargeDisplaySize();

          await tester.pumpApp(HomeView());
          final finder = find.byWidgetPredicate(
            (widget) =>
                widget is SudokuTextButton &&
                widget.key == mediumGameTextButtonKey &&
                widget.onPressed != null,
          );
          expect(
            finder,
            findsOneWidget,
          );
          await tester.tap(find.byKey(mediumGameTextButtonKey));
          await tester.pumpAndSettle();
        });
      });

      group('difficult mode', () {
        testWidgets('exists in the widget tree', (tester) async {
          await tester.pumpApp(HomeView());
          expect(find.byKey(difficultGameKey), findsOneWidget);
        });

        testWidgets('onPressed is defined', (tester) async {
          // To avoid the below warning:
          // Maybe the widget is actually off-screen, or another widget is
          // obscuring it, or the widget cannot receive pointer events
          tester.setLargeDisplaySize();

          await tester.pumpApp(HomeView());
          final finder = find.byWidgetPredicate(
            (widget) =>
                widget is SudokuTextButton &&
                widget.key == difficultGameTextButtonKey &&
                widget.onPressed != null,
          );
          expect(
            finder,
            findsOneWidget,
          );
          await tester.tap(find.byKey(difficultGameTextButtonKey));
          await tester.pumpAndSettle();
        });
      });

      group('expert mode', () {
        testWidgets('exists in the widget tree', (tester) async {
          await tester.pumpApp(HomeView());
          expect(find.byKey(expertyGameKey), findsOneWidget);
        });

        testWidgets('onPressed is defined', (tester) async {
          // To avoid the below warning:
          // Maybe the widget is actually off-screen, or another widget is
          // obscuring it, or the widget cannot receive pointer events
          tester.setLargeDisplaySize();

          await tester.pumpApp(HomeView());
          final finder = find.byWidgetPredicate(
            (widget) =>
                widget is SudokuTextButton &&
                widget.key == expertGameTextButtonKey &&
                widget.onPressed != null,
          );
          expect(
            finder,
            findsOneWidget,
          );
          await tester.tap(find.byKey(expertGameTextButtonKey));
          await tester.pumpAndSettle();
        });
      });
    });
  });
}
