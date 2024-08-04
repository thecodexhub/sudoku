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
    required AuthenticationRepository authenticationRepository,
    required PlayerRepository playerRepository,
  })  : _apiClient = apiClient,
        _puzzleRepository = puzzleRepository,
        _authenticationRepository = authenticationRepository,
        _playerRepository = playerRepository,
        super(const HomeState()) {
    on<SudokuCreationRequested>(_onSudokuCreationRequested);
    on<UnfinishedPuzzleSubscriptionRequested>(_onPuzzleSubscriptionRequested);
    on<UnfinishedPuzzleResumed>(_onUnfinishedPuzzleResumed);
    on<PlayerSubscriptionRequested>(_onPlayerSubscriptionRequested);
    on<NewPuzzleAttempted>(_onNewPuzzleAttempted);
  }

  final SudokuAPI _apiClient;
  final PuzzleRepository _puzzleRepository;
  final AuthenticationRepository _authenticationRepository;
  final PlayerRepository _playerRepository;

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

  FutureOr<void> _onPuzzleSubscriptionRequested(
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

  FutureOr<void> _onPlayerSubscriptionRequested(
    PlayerSubscriptionRequested event,
    Emitter<HomeState> emit,
  ) async {
    final userId = _authenticationRepository.currentUser.id;
    await emit.forEach(
      _playerRepository.getPlayer(userId),
      onData: (player) => state.copyWith(
        player: () => player,
      ),
      onError: (_, __) => state.copyWith(
        player: () => Player.empty,
      ),
    );
  }

  FutureOr<void> _onNewPuzzleAttempted(
    NewPuzzleAttempted event,
    Emitter<HomeState> emit,
  ) async {
    final userId = _authenticationRepository.currentUser.id;
    final updatedPlayer = state.player.updateAttemptCount(event.difficulty);
    try {
      await _playerRepository.updatePlayer(userId, updatedPlayer);
    } catch (_) {}
  }
}
