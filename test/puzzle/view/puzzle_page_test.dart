// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/puzzle/puzzle.dart';
import 'package:sudoku/repository/repository.dart';
import 'package:sudoku/sudoku/sudoku.dart';
import 'package:sudoku/timer/timer.dart';

import '../../helpers/helpers.dart';

void main() {
  group('PuzzlePage', () {
    late Puzzle puzzle;
    late PuzzleBloc puzzleBloc;
    late TimerBloc timerBloc;
    late TimerState timerState;
    late PuzzleRepository puzzleRepository;

    setUp(() {
      puzzle = MockPuzzle();
      puzzleRepository = MockPuzzleRepository();
      puzzleBloc = MockPuzzleBloc();
      timerBloc = MockTimerBloc();
      timerState = MockTimerState();

      when(() => puzzle.sudoku).thenReturn(sudoku3x3);
      when(() => puzzle.difficulty).thenReturn(Difficulty.medium);
      when(() => puzzle.remainingMistakes).thenReturn(3);
      when(() => puzzle.remainingHints).thenReturn(3);

      when(() => puzzleRepository.fetchPuzzleFromCache()).thenReturn(puzzle);

      when(() => timerState.secondsElapsed).thenReturn(167);
      when(() => timerState.isRunning).thenReturn(true);
      when(() => timerBloc.state).thenReturn(timerState);
    });

    testWidgets('renders PuzzleView on a large display', (tester) async {
      tester.setLargeDisplaySize();

      await tester.pumpApp(
        PuzzlePage(),
        puzzleRepository: puzzleRepository,
      );
      expect(find.byType(PuzzleView), findsOneWidget);
    });

    testWidgets('renders PuzzleView on a medium display', (tester) async {
      tester.setMediumDisplaySize();

      await tester.pumpApp(
        PuzzlePage(),
        puzzleRepository: puzzleRepository,
      );
      expect(find.byType(PuzzleView), findsOneWidget);
    });

    testWidgets('renders PuzzleView on a small display', (tester) async {
      tester.setSmallDisplaySize();

      await tester.pumpApp(
        PuzzlePage(),
        puzzleRepository: puzzleRepository,
      );
      expect(find.byType(PuzzleView), findsOneWidget);
    });

    testWidgets(
      'shows congrats dialog when puzzle status is completed',
      (tester) async {
        whenListen(
          puzzleBloc,
          Stream.fromIterable(
            [
              PuzzleState(
                puzzle: puzzle,
                puzzleStatus: PuzzleStatus.complete,
              ),
            ],
          ),
          initialState: PuzzleState(puzzle: puzzle),
        );

        await tester.pumpApp(
          PuzzleView(),
          puzzleBloc: puzzleBloc,
          timerBloc: timerBloc,
        );
        await tester.pump();

        expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is CongratsDialog &&
                widget.difficulty == Difficulty.medium &&
                widget.timeInSeconds == 167,
          ),
          findsOneWidget,
        );
        verify(() => timerBloc.add(TimerStopped())).called(1);
      },
    );

    testWidgets(
      'shows game over dialog when puzzle status is failed',
      (tester) async {
        whenListen(
          puzzleBloc,
          Stream.fromIterable(
            [
              PuzzleState(
                puzzleStatus: PuzzleStatus.failed,
              ),
            ],
          ),
          initialState: PuzzleState(),
        );

        await tester.pumpApp(
          PuzzleView(),
          puzzleBloc: puzzleBloc,
          timerBloc: timerBloc,
        );
        await tester.pump();

        expect(find.byType(GameOverDialog), findsOneWidget);
        verify(() => timerBloc.add(TimerStopped())).called(1);
      },
    );
  });

  group('PuzzleView', () {
    late Sudoku sudoku;
    late Puzzle puzzle;
    late PuzzleState puzzleState;
    late PuzzleBloc puzzleBloc;

    late TimerBloc timerBloc;
    late TimerState timerState;

    setUp(() {
      sudoku = MockSudoku();
      puzzle = MockPuzzle();
      puzzleState = MockPuzzleState();
      puzzleBloc = MockPuzzleBloc();

      timerState = MockTimerState();
      timerBloc = MockTimerBloc();

      when(() => sudoku.getDimesion()).thenReturn(3);
      when(() => sudoku.blocks).thenReturn([]);

      when(() => puzzle.sudoku).thenReturn(sudoku);
      when(() => puzzle.difficulty).thenReturn(Difficulty.medium);
      when(() => puzzle.remainingMistakes).thenReturn(2);
      when(() => puzzle.remainingHints).thenReturn(2);

      when(() => puzzleState.puzzle).thenReturn(puzzle);
      when(() => puzzleState.puzzleStatus).thenReturn(PuzzleStatus.failed);
      when(() => puzzleState.hintStatus).thenReturn(HintStatus.initial);
      when(() => puzzleBloc.state).thenReturn(puzzleState);

      when(() => timerState.secondsElapsed).thenReturn(167);
      when(() => timerState.isRunning).thenReturn(true);
      when(() => timerBloc.state).thenReturn(timerState);
    });

    testWidgets('renders with a [PopScope] widget', (tester) async {
      await tester.pumpApp(
        PuzzleView(),
        puzzleBloc: puzzleBloc,
        timerBloc: timerBloc,
      );
      final finder = find.byType(PopScope);
      expect(finder, findsOneWidget);
    });

    testWidgets(
      'does not add [UnfinishedPuzzleSaveRequested] when puzzle '
      'status is not incomplete',
      (tester) async {
        await tester.pumpApp(
          PuzzleView(),
          puzzleBloc: puzzleBloc,
          timerBloc: timerBloc,
        );

        final finder = find.byType(PopScope);
        Navigator.pop(tester.element(finder));

        verifyNever(() => puzzleBloc.add(UnfinishedPuzzleSaveRequested(167)));
      },
    );

    testWidgets(
      'adds [UnfinishedPuzzleSaveRequested] when puzzle status is incomplete',
      (tester) async {
        when(() => puzzleState.puzzleStatus).thenReturn(
          PuzzleStatus.incomplete,
        );

        await tester.pumpApp(
          PuzzleView(),
          puzzleBloc: puzzleBloc,
          timerBloc: timerBloc,
        );

        final finder = find.byType(PopScope);
        Navigator.pop(tester.element(finder));

        verify(
          () => puzzleBloc.add(UnfinishedPuzzleSaveRequested(167)),
        ).called(1);
      },
    );
  });

  group('PageHeader', () {
    late Puzzle puzzle;
    late PuzzleBloc puzzleBloc;
    late PuzzleState puzzleState;

    setUp(() {
      puzzle = MockPuzzle();
      puzzleBloc = MockPuzzleBloc();
      puzzleState = MockPuzzleState();

      when(() => puzzle.difficulty).thenReturn(Difficulty.medium);
      when(() => puzzleState.puzzle).thenReturn(puzzle);
      when(() => puzzleBloc.state).thenReturn(puzzleState);
    });

    testWidgets('renders difficulty on a large layout', (tester) async {
      tester.setLargeDisplaySize();
      await tester.pumpApp(const PageHeader(), puzzleBloc: puzzleBloc);
      expect(find.text('Medium'), findsOneWidget);
    });

    testWidgets('renders difficulty on a medium layout', (tester) async {
      tester.setMediumDisplaySize();
      await tester.pumpApp(const PageHeader(), puzzleBloc: puzzleBloc);
      expect(find.text('Medium'), findsOneWidget);
    });

    testWidgets('renders difficulty on a small layout', (tester) async {
      tester.setSmallDisplaySize();
      await tester.pumpApp(const PageHeader(), puzzleBloc: puzzleBloc);
      expect(find.text('Medium'), findsOneWidget);
    });
  });

  group('PuzzleViewLayout', () {
    late Sudoku sudoku;
    late Puzzle puzzle;
    late PuzzleState puzzleState;
    late PuzzleBloc puzzleBloc;
    late TimerBloc timerBloc;

    setUp(() {
      sudoku = MockSudoku();
      puzzle = MockPuzzle();
      puzzleState = MockPuzzleState();

      puzzleBloc = MockPuzzleBloc();
      timerBloc = MockTimerBloc();

      when(() => sudoku.blocks).thenReturn([]);
      when(() => sudoku.getDimesion()).thenReturn(3);

      when(() => puzzle.sudoku).thenReturn(sudoku);
      when(() => puzzle.difficulty).thenReturn(Difficulty.medium);
      when(() => puzzle.remainingMistakes).thenReturn(3);
      when(() => puzzle.remainingHints).thenReturn(3);

      when(() => puzzleState.puzzle).thenReturn(puzzle);
      when(() => puzzleState.puzzleStatus).thenReturn(PuzzleStatus.incomplete);
      when(() => puzzleState.hintStatus).thenReturn(HintStatus.initial);
      when(() => puzzleBloc.state).thenReturn(puzzleState);

      when(() => timerBloc.state).thenReturn(
        TimerState(secondsElapsed: 1, isRunning: true),
      );
    });

    testWidgets(
      'renders [PageHeader], [SudokuBoardView], [MistakesCountView], '
      '[SudokuTimer], [SudokuInputView], [InputEraseViewForLargeLayout] '
      'on a large display',
      (tester) async {
        tester.setLargeDisplaySize();

        await tester.pumpApp(
          PuzzleViewLayout(),
          puzzleBloc: puzzleBloc,
          timerBloc: timerBloc,
        );

        expect(find.byType(PageHeader), findsOneWidget);
        expect(find.byType(SudokuBoardView), findsOneWidget);
        expect(find.byType(MistakesCountView), findsOneWidget);

        expect(find.byType(SudokuTimer), findsOneWidget);
        expect(find.byType(SudokuInputView), findsOneWidget);
        expect(find.byType(InputEraseViewForLargeLayout), findsOneWidget);
      },
    );

    testWidgets(
      'renders [PageHeader], [SudokuBoardView], [MistakesCountView], '
      '[SudokuTimer], and [SudokuInputView] on a medium display',
      (tester) async {
        tester.setMediumDisplaySize();

        await tester.pumpApp(
          PuzzleViewLayout(),
          puzzleBloc: puzzleBloc,
          timerBloc: timerBloc,
        );

        expect(find.byType(PageHeader), findsOneWidget);
        expect(find.byType(SudokuBoardView), findsOneWidget);
        expect(find.byType(MistakesCountView), findsOneWidget);

        expect(find.byType(SudokuTimer), findsOneWidget);
        expect(find.byType(SudokuInputView), findsOneWidget);
        expect(find.byType(InputEraseViewForLargeLayout), findsNothing);
      },
    );

    testWidgets(
      'renders [PageHeader], [SudokuBoardView], [MistakesCountView], '
      '[SudokuTimer], and [SudokuInputView] on a small display',
      (tester) async {
        tester.setSmallDisplaySize();

        await tester.pumpApp(
          PuzzleViewLayout(),
          puzzleBloc: puzzleBloc,
          timerBloc: timerBloc,
        );

        expect(find.byType(PageHeader), findsOneWidget);
        expect(find.byType(SudokuBoardView), findsOneWidget);
        expect(find.byType(MistakesCountView), findsOneWidget);

        expect(find.byType(SudokuTimer), findsOneWidget);
        expect(find.byType(SudokuInputView), findsOneWidget);
        expect(find.byType(InputEraseViewForLargeLayout), findsNothing);
      },
    );
  });

  group('InputEraseViewForLargeLayout', () {
    late PuzzleBloc puzzleBloc;

    setUp(() {
      puzzleBloc = MockPuzzleBloc();
    });

    testWidgets('adds [SudokuInputErased] when tapped', (tester) async {
      await tester.pumpApp(
        InputEraseViewForLargeLayout(),
        puzzleBloc: puzzleBloc,
      );
      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      verify(() => puzzleBloc.add(SudokuInputErased())).called(1);
    });
  });

  group('SudokuBoardView', () {
    late PuzzleBloc puzzleBloc;
    late TimerBloc timerBloc;
    late Puzzle puzzle;
    late Sudoku sudoku;

    setUp(() {
      puzzleBloc = MockPuzzleBloc();
      timerBloc = MockTimerBloc();
      puzzle = MockPuzzle();
      sudoku = MockSudoku();

      when(() => sudoku.getDimesion()).thenReturn(3);
      when(() => sudoku.blocks).thenReturn([]);
      when(() => puzzle.sudoku).thenReturn(sudoku);

      when(() => puzzleBloc.state).thenReturn(
        PuzzleState(puzzle: puzzle),
      );

      when(() => timerBloc.state).thenReturn(
        TimerState(secondsElapsed: 1, isRunning: true),
      );
    });

    testWidgets('renders on a large layout', (tester) async {
      tester.setLargeDisplaySize();

      await tester.pumpApp(
        const SudokuBoardView(),
        puzzleBloc: puzzleBloc,
        timerBloc: timerBloc,
      );

      expect(find.byType(SudokuBoard), findsOneWidget);
    });

    testWidgets('renders on a medium layout', (tester) async {
      tester.setMediumDisplaySize();

      await tester.pumpApp(
        const SudokuBoardView(),
        puzzleBloc: puzzleBloc,
        timerBloc: timerBloc,
      );

      expect(find.byType(SudokuBoard), findsOneWidget);
    });

    testWidgets('renders on a small layout', (tester) async {
      tester.setSmallDisplaySize();

      await tester.pumpApp(
        const SudokuBoardView(),
        puzzleBloc: puzzleBloc,
        timerBloc: timerBloc,
      );

      expect(find.byType(SudokuBoard), findsOneWidget);
    });

    testWidgets(
      're-renders only when sudoku from [PuzzleState] changes',
      (tester) async {
        final block1 = Block(
          position: Position(x: 0, y: 0),
          correctValue: 1,
          currentValue: 1,
        );
        final block2 = Block(
          position: Position(x: 0, y: 1),
          correctValue: 2,
          currentValue: 2,
        );

        when(() => puzzleBloc.stream).thenAnswer(
          (_) => Stream.fromIterable([
            PuzzleState(
              puzzle: Puzzle(
                sudoku: Sudoku(blocks: const []),
                difficulty: Difficulty.medium,
              ),
            ),
            PuzzleState(
              puzzle: Puzzle(
                sudoku: Sudoku(blocks: [block1, block2]),
                difficulty: Difficulty.medium,
              ),
            ),
          ]),
        );

        await tester.pumpApp(
          const SudokuBoardView(),
          puzzleBloc: puzzleBloc,
          timerBloc: timerBloc,
        );

        await tester.pumpAndSettle();
        expect(find.byKey(Key('sudoku_board_view_0_0')), findsOneWidget);
        expect(find.byKey(Key('sudoku_board_view_0_1')), findsOneWidget);
      },
    );
  });
}
