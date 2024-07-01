part of 'sudoku_bloc.dart';

sealed class SudokuEvent extends Equatable {
  const SudokuEvent();
}

final class SudokuBlockSelected extends SudokuEvent {
  const SudokuBlockSelected(this.block);
  final Block block;

  @override
  List<Object> get props => [block];
}

final class SudokuInputTapped extends SudokuEvent {
  const SudokuInputTapped(this.input);
  final int input;

  @override
  List<Object> get props => [input];
}
