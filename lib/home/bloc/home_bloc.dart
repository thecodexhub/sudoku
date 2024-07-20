import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sudoku/api/api.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/puzzle/puzzle.dart';

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
      _puzzleRepository.storePuzzle(
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
}
