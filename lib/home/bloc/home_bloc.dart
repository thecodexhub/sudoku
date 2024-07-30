import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sudoku/api/api.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/puzzle/puzzle.dart';
import 'package:sudoku/repository/repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required SudokuAPI apiClient,
    required PuzzleRepository puzzleRepository,
  })  : _apiClient = apiClient,
        _puzzleRepository = puzzleRepository,
        super(const HomeState()) {
    on<SudokuCreationRequested>(_onSudokuCreationRequested);
    on<UnfinishedPuzzleSubscriptionRequested>(_onSubscriptionRequested);
    on<UnfinishedPuzzleResumed>(_onUnfinishedPuzzleResumed);
  }

  final SudokuAPI _apiClient;
  final PuzzleRepository _puzzleRepository;

  FutureOr<void> _onSudokuCreationRequested(
    SudokuCreationRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        difficulty: () => event.difficulty,
        sudokuCreationStatus: () => SudokuCreationStatus.inProgress,
        sudokuCreationError: () => null,
      ),
    );

    try {
      final sudoku = await _apiClient.createSudoku(
        difficulty: event.difficulty,
      );
      _puzzleRepository.savePuzzleToCache(
        puzzle: Puzzle(sudoku: sudoku, difficulty: event.difficulty),
      );
      emit(
        state.copyWith(
          sudokuCreationStatus: () => SudokuCreationStatus.completed,
        ),
      );
    } on SudokuInvalidRawDataException catch (_) {
      emit(
        state.copyWith(
          sudokuCreationStatus: () => SudokuCreationStatus.failed,
          sudokuCreationError: () => SudokuCreationErrorType.invalidRawData,
        ),
      );
    } on SudokuAPIClientException catch (_) {
      emit(
        state.copyWith(
          sudokuCreationStatus: () => SudokuCreationStatus.failed,
          sudokuCreationError: () => SudokuCreationErrorType.apiClient,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          sudokuCreationStatus: () => SudokuCreationStatus.failed,
          sudokuCreationError: () => SudokuCreationErrorType.unexpected,
        ),
      );
    }
  }

  FutureOr<void> _onSubscriptionRequested(
    UnfinishedPuzzleSubscriptionRequested event,
    Emitter<HomeState> emit,
  ) async {
    await emit.forEach(
      _puzzleRepository.getPuzzleFromLocalMemory(),
      onData: (puzzle) {
        return state.copyWith(
          unfinishedPuzzle: () => puzzle,
        );
      },
      onError: (_, __) => state.copyWith(
        unfinishedPuzzle: () => null,
      ),
    );
  }

  void _onUnfinishedPuzzleResumed(
    UnfinishedPuzzleResumed event,
    Emitter<HomeState> emit,
  ) {
    final unfinishedPuzzle = state.unfinishedPuzzle;
    if (unfinishedPuzzle == null) return;

    emit(
      state.copyWith(
        sudokuCreationStatus: () => SudokuCreationStatus.inProgress,
      ),
    );
    // Save the unfinished puzzle to the local cache, to be picked up by
    // PuzzleBloc, and at the same time, remove the unfinished saved puzzle
    // from local storage.
    _puzzleRepository
      ..savePuzzleToCache(puzzle: unfinishedPuzzle)
      ..clearPuzzleInLocalMemory();
    emit(
      state.copyWith(
        sudokuCreationStatus: () => SudokuCreationStatus.completed,
      ),
    );
  }
}
