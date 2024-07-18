// ignore_for_file: prefer_const_constructors

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/home/home.dart';
import 'package:sudoku/l10n/l10n.dart';
import 'package:sudoku/widgets/widgets.dart';

import '../helpers/helpers.dart';

void main() {
  group('SudokuFailureDialog', () {
    const largeFailueDialog = Key('sudoku_failure_dialog_large');
    const mediumFailueDialog = Key('sudoku_failure_dialog_medium');
    const smallFailueDialog = Key('sudoku_failure_dialog_small');

    SudokuFailureDialog createWidget({
      SudokuCreationErrorType? errorType,
    }) =>
        SudokuFailureDialog(
          errorType: errorType ?? SudokuCreationErrorType.unexpected,
        );

    late AppLocalizations l10n;

    setUpAll(() async {
      l10n = await AppLocalizations.delegate.load(Locale('en'));
    });

    testWidgets('renders on a large layout', (tester) async {
      tester.setLargeDisplaySize();

      await tester.pumpApp(createWidget());
      expect(find.byKey(largeFailueDialog), findsOneWidget);
    });

    testWidgets('renders on a medium layout', (tester) async {
      tester.setMediumDisplaySize();

      await tester.pumpApp(createWidget());
      expect(find.byKey(mediumFailueDialog), findsOneWidget);
    });

    testWidgets('renders on a small layout', (tester) async {
      tester.setSmallDisplaySize();

      await tester.pumpApp(createWidget());
      expect(find.byKey(smallFailueDialog), findsOneWidget);
    });

    testWidgets(
      'renders [errorWrongDataDialogSubtitle] when error '
      'type is [invalidRawData]',
      (tester) async {
        await tester.pumpApp(createWidget());
        expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is Text && widget.data == l10n.errorClientDialogSubtitle,
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'renders [errorClientDialogSubtitle] when error '
      'type is [unexpected]',
      (tester) async {
        await tester.pumpApp(createWidget());
        expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is Text && widget.data == l10n.errorClientDialogSubtitle,
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'renders [errorClientDialogSubtitle] when error '
      'type is [apiClient]',
      (tester) async {
        await tester.pumpApp(
          createWidget(
            errorType: SudokuCreationErrorType.apiClient,
          ),
        );
        expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is Text &&
                widget.data == l10n.errorClientDialogSubtitle,
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'renders [errorWrongDataDialogSubtitle] when error '
      'type is [invalidRawData]',
      (tester) async {
        await tester.pumpApp(
          createWidget(
            errorType: SudokuCreationErrorType.invalidRawData,
          ),
        );
        expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is Text &&
                widget.data == l10n.errorWrongDataDialogSubtitle,
          ),
          findsOneWidget,
        );
      },
    );
  });
}
