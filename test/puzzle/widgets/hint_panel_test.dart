// ignore_for_file: prefer_const_constructors

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/puzzle/puzzle.dart';
import 'package:sudoku/widgets/widgets.dart';

import '../../helpers/helpers.dart';

void main() {
  group('HintPanel', () {
    late Hint hint;
    late PuzzleState puzzleState;
    late PuzzleBloc puzzleBloc;

    setUp(() {
      hint = MockHint();
      puzzleState = MockPuzzleState();
      puzzleBloc = MockPuzzleBloc();

      when(() => hint.observation).thenReturn('test observation');
      when(() => hint.explanation).thenReturn('test explanation');
      when(() => hint.solution).thenReturn('test solution');

      when(() => puzzleState.hintStatus).thenReturn(HintStatus.fetchSuccess);
      when(() => puzzleState.hint).thenReturn(hint);

      when(() => puzzleBloc.state).thenReturn(puzzleState);
    });

    testWidgets('renders on a large layout', (tester) async {
      tester.setLargeDisplaySize();
      await tester.pumpApp(HintPanel(), puzzleBloc: puzzleBloc);
      expect(find.byType(DisplayHint), findsOneWidget);
    });

    testWidgets('renders on a medium layout', (tester) async {
      tester.setMediumDisplaySize();
      await tester.pumpApp(HintPanel(), puzzleBloc: puzzleBloc);
      expect(find.byType(DisplayHint), findsOneWidget);
    });

    testWidgets('renders on a small layout', (tester) async {
      tester.setSmallDisplaySize();
      await tester.pumpApp(HintPanel(), puzzleBloc: puzzleBloc);
      expect(find.byType(DisplayHint), findsOneWidget);
    });

    testWidgets(
      'displays error widget when hint is null and status is failed',
      (tester) async {
        when(() => puzzleState.hintStatus).thenReturn(HintStatus.fetchFailed);
        when(() => puzzleState.hint).thenReturn(null);

        await tester.pumpApp(HintPanel(), puzzleBloc: puzzleBloc);
        expect(find.byType(DisplayError), findsOneWidget);
      },
    );

    testWidgets(
      'displays hint widget when hint is not-null and status is success',
      (tester) async {
        when(() => puzzleState.hintStatus).thenReturn(HintStatus.fetchSuccess);

        await tester.pumpApp(HintPanel(), puzzleBloc: puzzleBloc);
        expect(find.byType(DisplayHint), findsOneWidget);
      },
    );

    testWidgets(
      'adds [HintInteractioCompleted] when text button is '
      'tapped in succes status',
      (tester) async {
        when(() => puzzleState.hintStatus).thenReturn(HintStatus.fetchSuccess);
        await tester.pumpApp(HintPanel(), puzzleBloc: puzzleBloc);

        final finder = find.byType(SudokuTextButton);
        await tester.tap(finder);
        await tester.pump();

        verify(() => puzzleBloc.add(HintInteractioCompleted())).called(1);
      },
    );

    testWidgets(
      'displays nothing, only a SizedBox when hint status is '
      'other than success and failed',
      (tester) async {
        when(() => puzzleState.hintStatus).thenReturn(HintStatus.initial);
        await tester.pumpApp(HintPanel(), puzzleBloc: puzzleBloc);

        expect(find.byType(DisplayError), findsNothing);
        expect(find.byType(DisplayHint), findsNothing);

        expect(find.byType(SizedBox), findsOneWidget);
      },
    );
  });
}
