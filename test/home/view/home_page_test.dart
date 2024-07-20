// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sudoku/home/home.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/puzzle/puzzle.dart';
import 'package:sudoku/widgets/widgets.dart';

import '../../helpers/helpers.dart';

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

    const loadingDialogKey = Key('sudoku_loading_dialog');
    const failureDialogKey = Key('sudoku_failure_dialog');

    late HomeBloc homeBloc;

    setUp(() {
      homeBloc = MockHomeBloc();
      when(() => homeBloc.state).thenReturn(HomeState());
    });

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

    testWidgets(
      'shows loading dialog when [SudokuCreationStatus] is in progress',
      (tester) async {
        whenListen(
          homeBloc,
          Stream.fromIterable(
            [
              HomeState(
                difficulty: Difficulty.medium,
                sudokuCreationStatus: SudokuCreationStatus.inProgress,
              ),
            ],
          ),
          initialState: HomeState(),
        );

        await tester.pumpApp(HomeView(), homeBloc: homeBloc);
        await tester.pump();

        expect(find.byKey(loadingDialogKey), findsOneWidget);
        expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is SudokuLoadingDialog && widget.difficulty == 'medium',
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'shows failure dialog when [SudokuCreationStatus] is failed',
      (tester) async {
        whenListen(
          homeBloc,
          Stream.fromIterable(
            [
              HomeState(
                difficulty: Difficulty.medium,
                sudokuCreationStatus: SudokuCreationStatus.inProgress,
              ),
              HomeState(
                sudokuCreationStatus: SudokuCreationStatus.failed,
                sudokuCreationError: SudokuCreationErrorType.unexpected,
              ),
            ],
          ),
          initialState: HomeState(),
        );

        await tester.pumpApp(HomeView(), homeBloc: homeBloc);
        await tester.pump();

        expect(find.byKey(failureDialogKey), findsOneWidget);
        expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is SudokuFailureDialog &&
                widget.errorType == SudokuCreationErrorType.unexpected,
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'routes to [PuzzlePage] when [SudokuCreationStatus] is completed',
      (tester) async {
        final puzzle = MockPuzzle();
        when(() => puzzle.sudoku).thenReturn(sudoku3x3);
        when(() => puzzle.difficulty).thenReturn(Difficulty.medium);
        when(() => puzzle.remainingMistakes).thenReturn(3);

        final puzzleRepository = MockPuzzleRepository();
        when(puzzleRepository.getPuzzle).thenReturn(puzzle);

        whenListen(
          homeBloc,
          Stream.fromIterable(
            [
              HomeState(
                difficulty: Difficulty.medium,
                sudokuCreationStatus: SudokuCreationStatus.inProgress,
              ),
              HomeState(
                sudokuCreationStatus: SudokuCreationStatus.completed,
              ),
            ],
          ),
          initialState: HomeState(),
        );

        await tester.pumpApp(
          HomeView(),
          homeBloc: homeBloc,
          puzzleRepository: puzzleRepository,
        );
        await tester.pumpAndSettle();

        expect(find.byType(PuzzlePage), findsOneWidget);
      },
    );

    group('Daily Challenge', () {
      late HomeBloc homeBloc;

      setUp(() {
        homeBloc = MockHomeBloc();
        when(() => homeBloc.state).thenReturn(const HomeState());
      });

      testWidgets('exists in the widget tree', (tester) async {
        await tester.pumpApp(HomeView(), homeBloc: homeBloc);
        expect(find.byKey(dailyChallengeKey), findsOneWidget);
      });

      testWidgets('onPressed is defined', (tester) async {
        await tester.pumpApp(HomeView(), homeBloc: homeBloc);
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
      late HomeBloc homeBloc;

      setUp(() {
        homeBloc = MockHomeBloc();
        when(() => homeBloc.state).thenReturn(const HomeState());
      });

      testWidgets('exists in the widget tree', (tester) async {
        await tester.pumpApp(HomeView(), homeBloc: homeBloc);
        expect(find.byKey(resumePuzzleKey), findsOneWidget);
      });

      testWidgets('onPressed is defined', (tester) async {
        await tester.pumpApp(HomeView(), homeBloc: homeBloc);
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

      late HomeBloc homeBloc;

      setUp(() {
        homeBloc = MockHomeBloc();
        when(() => homeBloc.state).thenReturn(const HomeState());
      });

      group(
        'easy mode',
        () {
          testWidgets('exists in the widget tree', (tester) async {
            await tester.pumpApp(HomeView(), homeBloc: homeBloc);
            expect(find.byKey(easyGameKey), findsOneWidget);
          });

          testWidgets('adds [SudokuCreationRequested] on pressed',
              (tester) async {
            // To avoid the below warning:
            // Maybe the widget is actually off-screen, or another widget is
            // obscuring it, or the widget cannot receive pointer events
            tester.setLargeDisplaySize();

            await tester.pumpApp(HomeView(), homeBloc: homeBloc);
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
            verify(
              () => homeBloc.add(SudokuCreationRequested(Difficulty.easy)),
            ).called(1);
          });
        },
      );

      group(
        'medium mode',
        () {
          testWidgets('exists in the widget tree', (tester) async {
            await tester.pumpApp(HomeView(), homeBloc: homeBloc);
            expect(find.byKey(mediumGameKey), findsOneWidget);
          });

          testWidgets('adds [SudokuCreationRequested] on pressed',
              (tester) async {
            // To avoid the below warning:
            // Maybe the widget is actually off-screen, or another widget is
            // obscuring it, or the widget cannot receive pointer events
            tester.setLargeDisplaySize();

            await tester.pumpApp(HomeView(), homeBloc: homeBloc);
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

            verify(
              () => homeBloc.add(SudokuCreationRequested(Difficulty.medium)),
            ).called(1);
          });
        },
      );

      group(
        'difficult mode',
        () {
          testWidgets('exists in the widget tree', (tester) async {
            await tester.pumpApp(HomeView(), homeBloc: homeBloc);
            expect(find.byKey(difficultGameKey), findsOneWidget);
          });

          testWidgets('adds [SudokuCreationRequested] on pressed',
              (tester) async {
            // To avoid the below warning:
            // Maybe the widget is actually off-screen, or another widget is
            // obscuring it, or the widget cannot receive pointer events
            tester.setLargeDisplaySize();

            await tester.pumpApp(HomeView(), homeBloc: homeBloc);
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

            verify(
              () => homeBloc.add(SudokuCreationRequested(Difficulty.difficult)),
            ).called(1);
          });
        },
      );

      group('expert mode', () {
        testWidgets('exists in the widget tree', (tester) async {
          await tester.pumpApp(HomeView(), homeBloc: homeBloc);
          expect(find.byKey(expertyGameKey), findsOneWidget);
        });

        testWidgets(
          'adds [SudokuCreationRequested] on pressed',
          (tester) async {
            // To avoid the below warning:
            // Maybe the widget is actually off-screen, or another widget is
            // obscuring it, or the widget cannot receive pointer events
            tester.setLargeDisplaySize();

            await tester.pumpApp(HomeView(), homeBloc: homeBloc);
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

            verify(
              () => homeBloc.add(SudokuCreationRequested(Difficulty.expert)),
            ).called(1);
          },
        );
      });
    });
  });
}
