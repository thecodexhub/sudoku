import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/widgets/widgets.dart';

import '../helpers/helpers.dart';

void main() {
  group('SudokuLoadingDialog', () {
    const largeLoadingKey = Key('sudoku_loading_dialog_large');
    const mediumLoadingKey = Key('sudoku_loading_dialog_medium');
    const smallLoadingKey = Key('sudoku_loading_dialog_small');

    final widget = SudokuLoadingDialog(
      difficulty: Difficulty.medium.name,
    );

    testWidgets('renders on a large layout', (tester) async {
      tester.setLargeDisplaySize();

      await tester.pumpApp(widget);
      expect(find.byKey(largeLoadingKey), findsOneWidget);
    });

    testWidgets('renders on a medium layout', (tester) async {
      tester.setMediumDisplaySize();
      
      await tester.pumpApp(widget);
      expect(find.byKey(mediumLoadingKey), findsOneWidget);
    });

    testWidgets('renders on a small layout', (tester) async {
      tester.setSmallDisplaySize();
      
      await tester.pumpApp(widget);
      expect(find.byKey(smallLoadingKey), findsOneWidget);
    });
  });
}
