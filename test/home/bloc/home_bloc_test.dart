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
      apiClient = MockSudokuAPI();
      puzzleRepository = MockPuzzleRepository();
      when(() => apiClient.createSudoku(difficulty: any(named: 'difficulty')))
          .thenAnswer((_) => Future.value(sudoku));
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
          () => puzzleRepository.storePuzzle(
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
}
