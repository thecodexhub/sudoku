import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sudoku/api/api.dart';
import 'package:sudoku/models/models.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required SudokuAPI apiClient,
  })  : _apiClient = apiClient,
        super(const HomeState()) {
    on<SudokuCreationRequested>(_onSudokuCreationRequested);
  }

  final SudokuAPI _apiClient;

  FutureOr<void> _onSudokuCreationRequested(
    SudokuCreationRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        sudoku: () => null,
        difficulty: () => event.difficulty,
        sudokuCreationStatus: () => SudokuCreationStatus.inProgress,
        sudokuCreationError: () => null,
      ),
    );

    try {
      final sudoku = await _apiClient.createSudoku(
        difficulty: event.difficulty,
      );
      emit(
        state.copyWith(
          sudoku: () => sudoku,
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
