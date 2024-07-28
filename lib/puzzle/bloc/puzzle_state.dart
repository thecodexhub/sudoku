// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'puzzle_bloc.dart';

enum HintStatus {
  initial,
  fetchInProgress,
  fetchSuccess,
  fetchFailed,
  interactionEnded,
}

class PuzzleState extends Equatable {
  const PuzzleState({
    this.puzzle = const Puzzle(
      sudoku: Sudoku(blocks: []),
      difficulty: Difficulty.easy,
    ),
    this.puzzleStatus = PuzzleStatus.incomplete,
    this.hintStatus = HintStatus.initial,
    this.highlightedBlocks = const [],
    this.selectedBlock,
    this.hint,
  });

  final Puzzle puzzle;
  final PuzzleStatus puzzleStatus;
  final HintStatus hintStatus;
  final List<Block> highlightedBlocks;
  final Block? selectedBlock;
  final Hint? hint;

  @override
  List<Object?> get props => [
        puzzle,
        puzzleStatus,
        hintStatus,
        highlightedBlocks,
        selectedBlock,
        hint,
      ];

  PuzzleState copyWith({
    Puzzle Function()? puzzle,
    PuzzleStatus Function()? puzzleStatus,
    HintStatus Function()? hintStatus,
    List<Block> Function()? highlightedBlocks,
    Block? Function()? selectedBlock,
    Hint? Function()? hint,
  }) {
    return PuzzleState(
      puzzle: puzzle != null ? puzzle() : this.puzzle,
      puzzleStatus: puzzleStatus != null ? puzzleStatus() : this.puzzleStatus,
      hintStatus: hintStatus != null ? hintStatus() : this.hintStatus,
      highlightedBlocks: highlightedBlocks != null
          ? highlightedBlocks()
          : this.highlightedBlocks,
      selectedBlock:
          selectedBlock != null ? selectedBlock() : this.selectedBlock,
      hint: hint != null ? hint() : this.hint,
    );
  }
}

extension HintStatusExtension on HintStatus {
  bool get isFetchInProgress {
    return this == HintStatus.fetchInProgress;
  }

  bool get isInteractionEnded {
    return this == HintStatus.interactionEnded;
  }
}
