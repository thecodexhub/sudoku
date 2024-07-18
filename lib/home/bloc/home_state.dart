// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

enum SudokuCreationStatus { initial, inProgress, completed, failed }

enum SudokuCreationErrorType { unexpected, invalidRawData, apiClient }

class HomeState extends Equatable {
  const HomeState({
    this.sudoku,
    this.difficulty,
    this.sudokuCreationStatus = SudokuCreationStatus.initial,
    this.sudokuCreationError,
  });

  final Sudoku? sudoku;
  final Difficulty? difficulty;
  final SudokuCreationStatus sudokuCreationStatus;
  final SudokuCreationErrorType? sudokuCreationError;

  @override
  List<Object?> get props => [
        sudoku,
        difficulty,
        sudokuCreationStatus,
        sudokuCreationError,
      ];

  HomeState copyWith({
    Sudoku? Function()? sudoku,
    Difficulty? Function()? difficulty,
    SudokuCreationStatus Function()? sudokuCreationStatus,
    SudokuCreationErrorType? Function()? sudokuCreationError,
  }) {
    return HomeState(
      sudoku: sudoku != null ? sudoku() : this.sudoku,
      difficulty: difficulty != null ? difficulty() : this.difficulty,
      sudokuCreationStatus: sudokuCreationStatus != null
          ? sudokuCreationStatus()
          : this.sudokuCreationStatus,
      sudokuCreationError: sudokuCreationError != null
          ? sudokuCreationError()
          : this.sudokuCreationError,
    );
  }
}
