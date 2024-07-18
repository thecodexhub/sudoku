part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

final class SudokuCreationRequested extends HomeEvent {
  const SudokuCreationRequested(this.difficulty);

  final Difficulty difficulty;

  @override
  List<Object?> get props => [difficulty];
}
