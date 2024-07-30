// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sudoku/api/api.dart';
import 'package:sudoku/home/home.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/puzzle/puzzle.dart';
import 'package:sudoku/repository/repository.dart';

import '../../helpers/helpers.dart';

void main() {
  group('HomeBloc', () {
    late Puzzle puzzle;
    late SudokuAPI apiClient;
    late PuzzleRepository puzzleRepository;

    const sudoku = Sudoku(
      blocks: [
        Block(
          position: Position(x: 0, y: 0),
          correctValue: 7,
          currentValue: 7,
        ),
      ],
    );

    setUp(() {
      puzzle = MockPuzzle();
      apiClient = MockSudokuAPI();
      puzzleRepository = MockPuzzleRepository();

      when(() => apiClient.createSudoku(difficulty: any(named: 'difficulty')))
          .thenAnswer(
        (_) => Future.value(sudoku),
      );
      when(() => puzzleRepository.getPuzzleFromLocalMemory()).thenAnswer(
        (_) => Stream.value(puzzle),
      );
      when(() => puzzleRepository.clearPuzzleInLocalMemory()).thenAnswer(
        (_) async {},
      );
    });

    setUpAll(() {
      registerFallbackValue(Difficulty.easy);
    });

    HomeBloc buildBloc() {
      return HomeBloc(
        apiClient: apiClient,
        puzzleRepository: puzzleRepository,
      );
    }

    test('constructor works correctly', () {
      expect(buildBloc, returnsNormally);
    });

    test('has an initial state', () {
      expect(buildBloc().state, equals(HomeState()));
    });

    group('SudokuCreationRequested', () {
      blocTest<HomeBloc, HomeState>(
        'emits state with in progress and completed [SudokuCreationStatus] '
        'along with defined difficulty',
        build: buildBloc,
        act: (bloc) => bloc.add(SudokuCreationRequested(Difficulty.medium)),
        expect: () => [
          HomeState(
            difficulty: Difficulty.medium,
            sudokuCreationStatus: SudokuCreationStatus.inProgress,
            sudokuCreationError: null,
          ),
          HomeState(
            difficulty: Difficulty.medium,
            sudokuCreationStatus: SudokuCreationStatus.completed,
            sudokuCreationError: null,
          ),
        ],
        verify: (_) {
          verify(
            () => apiClient.createSudoku(difficulty: Difficulty.medium),
          ).called(1);
          verify(
            () => puzzleRepository.savePuzzleToCache(
              puzzle: Puzzle(sudoku: sudoku, difficulty: Difficulty.medium),
            ),
          ).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'emits failed [SudokuCreationStatus] along with error type '
        'when api exception is thrown',
        build: buildBloc,
        setUp: () => when(
          () => apiClient.createSudoku(difficulty: any(named: 'difficulty')),
        ).thenThrow(SudokuAPIClientException()),
        act: (bloc) => bloc.add(SudokuCreationRequested(Difficulty.medium)),
        expect: () => [
          HomeState(
            difficulty: Difficulty.medium,
            sudokuCreationStatus: SudokuCreationStatus.inProgress,
            sudokuCreationError: null,
          ),
          HomeState(
            difficulty: Difficulty.medium,
            sudokuCreationStatus: SudokuCreationStatus.failed,
            sudokuCreationError: SudokuCreationErrorType.apiClient,
          ),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'emits failed [SudokuCreationStatus] along with error type '
        'when api returns invalid raw data',
        build: buildBloc,
        setUp: () => when(
          () => apiClient.createSudoku(difficulty: any(named: 'difficulty')),
        ).thenThrow(SudokuInvalidRawDataException()),
        act: (bloc) => bloc.add(SudokuCreationRequested(Difficulty.medium)),
        expect: () => [
          HomeState(
            difficulty: Difficulty.medium,
            sudokuCreationStatus: SudokuCreationStatus.inProgress,
            sudokuCreationError: null,
          ),
          HomeState(
            difficulty: Difficulty.medium,
            sudokuCreationStatus: SudokuCreationStatus.failed,
            sudokuCreationError: SudokuCreationErrorType.invalidRawData,
          ),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'emits failed [SudokuCreationStatus] along with unexpected error type '
        'when api method returns exception',
        build: buildBloc,
        setUp: () => when(
          () => apiClient.createSudoku(difficulty: any(named: 'difficulty')),
        ).thenThrow(Exception()),
        act: (bloc) => bloc.add(SudokuCreationRequested(Difficulty.medium)),
        expect: () => [
          HomeState(
            difficulty: Difficulty.medium,
            sudokuCreationStatus: SudokuCreationStatus.inProgress,
            sudokuCreationError: null,
          ),
          HomeState(
            difficulty: Difficulty.medium,
            sudokuCreationStatus: SudokuCreationStatus.failed,
            sudokuCreationError: SudokuCreationErrorType.unexpected,
          ),
        ],
      );
    });

    group('UnfinishedPuzzleSubscriptionRequested', () {
      blocTest<HomeBloc, HomeState>(
        'starts listening to getPuzzleFromLocalMemory from PuzzleRepository',
        build: buildBloc,
        act: (bloc) => bloc.add(UnfinishedPuzzleSubscriptionRequested()),
        verify: (_) {
          verify(() => puzzleRepository.getPuzzleFromLocalMemory()).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'emits state with updated [unfinishedPuzzle] when repository '
        'getPuzzleFromLocalMemory emits a new puzzle',
        build: buildBloc,
        act: (bloc) => bloc.add(UnfinishedPuzzleSubscriptionRequested()),
        expect: () => [
          HomeState(unfinishedPuzzle: puzzle),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'emits state with null [unfinishedPuzzle] when repository '
        'getPuzzleFromLocalMemory emits an error',
        build: buildBloc,
        setUp: () {
          when(() => puzzleRepository.getPuzzleFromLocalMemory())
              .thenAnswer((_) => Stream.error(Exception()));
        },
        act: (bloc) => bloc.add(UnfinishedPuzzleSubscriptionRequested()),
        expect: () => [
          HomeState(unfinishedPuzzle: null),
        ],
      );
    });

    group('UnfinishedPuzzleResumed', () {
      blocTest<HomeBloc, HomeState>(
        'calls the savePuzzleToCache and clearPuzzleInLocalMemory '
        'from PuzzleRepository',
        build: buildBloc,
        act: (bloc) => bloc.add(UnfinishedPuzzleResumed()),
        seed: () => HomeState(unfinishedPuzzle: puzzle),
        verify: (_) {
          verify(
            () => puzzleRepository.savePuzzleToCache(puzzle: puzzle),
          ).called(1);
          verify(() => puzzleRepository.clearPuzzleInLocalMemory()).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'does not emit state changes when unfinishedPuzzle is null',
        build: buildBloc,
        act: (bloc) => bloc.add(UnfinishedPuzzleResumed()),
        seed: () => HomeState(unfinishedPuzzle: null),
        verify: (_) {
          verifyNever(() => puzzleRepository.savePuzzleToCache(puzzle: puzzle));
          verifyNever(() => puzzleRepository.clearPuzzleInLocalMemory());
        },
        expect: () => <HomeState>[],
      );

      blocTest<HomeBloc, HomeState>(
        'emits the loading status and then the completed puzzleStatus',
        build: buildBloc,
        act: (bloc) => bloc.add(UnfinishedPuzzleResumed()),
        seed: () => HomeState(unfinishedPuzzle: puzzle),
        expect: () => [
          HomeState(
            sudokuCreationStatus: SudokuCreationStatus.inProgress,
            unfinishedPuzzle: puzzle,
          ),
          HomeState(
            sudokuCreationStatus: SudokuCreationStatus.completed,
            unfinishedPuzzle: puzzle,
          ),
        ],
      );
    });
  });
}
