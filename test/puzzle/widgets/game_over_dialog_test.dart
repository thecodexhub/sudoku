// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/puzzle/puzzle.dart';
import 'package:sudoku/widgets/widgets.dart';

import '../../helpers/helpers.dart';

void main() {
  group('GameOverDialog', () {
    const largeKey = Key('game_over_dialog_large');
    const mediumKey = Key('game_over_dialog_medium');
    const smallKey = Key('game_over_dialog_small');

    GameOverDialog createWidget() => GameOverDialog();

    testWidgets('renders on a large display', (tester) async {
      tester.setLargeDisplaySize();
      await tester.pumpApp(createWidget());
      expect(find.byKey(largeKey), findsOneWidget);
    });

    testWidgets('renders on a medium display', (tester) async {
      tester.setMediumDisplaySize();
      await tester.pumpApp(createWidget());
      expect(find.byKey(mediumKey), findsOneWidget);
    });

    testWidgets('renders on a small display', (tester) async {
      tester.setSmallDisplaySize();
      await tester.pumpApp(createWidget());
      expect(find.byKey(smallKey), findsOneWidget);
    });

    group('Navigator', () {
      testWidgets(
        'pops back to first route when tapped [SudokuElevatedButton]',
        (tester) async {
          await tester.pumpApp(createWidget());

          final finder = find.byType(SudokuElevatedButton);
          expect(finder, findsOneWidget);

          await tester.tap(finder);
          await tester.pumpAndSettle();

          expect(Navigator.of(tester.element(finder)).canPop(), isFalse);
        },
      );
    });
  });
}
