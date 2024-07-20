part of 'puzzle_bloc.dart';

sealed class PuzzleEvent extends Equatable {
  const PuzzleEvent();

  @override
  List<Object> get props => [];
}

final class PuzzleInitialized extends PuzzleEvent {
  const PuzzleInitialized();
}

final class SudokuBlockSelected extends PuzzleEvent {
  const SudokuBlockSelected(this.block);

  final Block block;

  @override
  List<Object> get props => [block];
}

final class SudokuInputEntered extends PuzzleEvent {
  const SudokuInputEntered(this.input);

  final int input;

  @override
  List<Object> get props => [input];
}

final class SudokuInputErased extends PuzzleEvent {
  const SudokuInputErased();
}