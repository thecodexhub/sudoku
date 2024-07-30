// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

enum SudokuCreationStatus { initial, inProgress, completed, failed }

enum SudokuCreationErrorType { unexpected, invalidRawData, apiClient }

class HomeState extends Equatable {
  const HomeState({
    this.difficulty,
    this.sudokuCreationStatus = SudokuCreationStatus.initial,
    this.sudokuCreationError,
    this.unfinishedPuzzle,
  });

  final Difficulty? difficulty;
  final SudokuCreationStatus sudokuCreationStatus;
  final SudokuCreationErrorType? sudokuCreationError;
  final Puzzle? unfinishedPuzzle;

  @override
  List<Object?> get props => [
        difficulty,
        sudokuCreationStatus,
        sudokuCreationError,
        unfinishedPuzzle,
      ];

  HomeState copyWith({
    Difficulty? Function()? difficulty,
    SudokuCreationStatus Function()? sudokuCreationStatus,
    SudokuCreationErrorType? Function()? sudokuCreationError,
    Puzzle? Function()? unfinishedPuzzle,
  }) {
    return HomeState(
      difficulty: difficulty != null ? difficulty() : this.difficulty,
      sudokuCreationStatus: sudokuCreationStatus != null
          ? sudokuCreationStatus()
          : this.sudokuCreationStatus,
      sudokuCreationError: sudokuCreationError != null
          ? sudokuCreationError()
          : this.sudokuCreationError,
      unfinishedPuzzle:
          unfinishedPuzzle != null ? unfinishedPuzzle() : this.unfinishedPuzzle,
    );
  }
}
