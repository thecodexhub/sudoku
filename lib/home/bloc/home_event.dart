part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

final class SudokuCreationRequested extends HomeEvent {
  const SudokuCreationRequested(this.difficulty);

  final Difficulty difficulty;

  @override
  List<Object?> get props => [difficulty];
}

final class UnfinishedPuzzleSubscriptionRequested extends HomeEvent {
  const UnfinishedPuzzleSubscriptionRequested();
}

final class UnfinishedPuzzleResumed extends HomeEvent {
  const UnfinishedPuzzleResumed();
}

final class PlayerSubscriptionRequested extends HomeEvent {
  const PlayerSubscriptionRequested();
}

final class NewPuzzleAttempted extends HomeEvent {
  const NewPuzzleAttempted(this.difficulty);

  final Difficulty difficulty;

  @override
  List<Object?> get props => [difficulty];
}
