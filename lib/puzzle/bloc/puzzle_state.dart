// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'puzzle_bloc.dart';

class PuzzleState extends Equatable {
  const PuzzleState({
    this.puzzle = const Puzzle(
      sudoku: Sudoku(blocks: []),
      difficulty: Difficulty.easy,
    ),
    this.puzzleStatus = PuzzleStatus.incomplete,
    this.highlightedBlocks = const [],
    this.selectedBlock,
  });

  final Puzzle puzzle;
  final PuzzleStatus puzzleStatus;
  final List<Block> highlightedBlocks;
  final Block? selectedBlock;

  @override
  List<Object?> get props => [
        puzzle,
        puzzleStatus,
        highlightedBlocks,
        selectedBlock,
      ];

  PuzzleState copyWith({
    Puzzle Function()? puzzle,
    PuzzleStatus Function()? puzzleStatus,
    List<Block> Function()? highlightedBlocks,
    Block? Function()? selectedBlock,
  }) {
    return PuzzleState(
      puzzle: puzzle != null ? puzzle() : this.puzzle,
      puzzleStatus: puzzleStatus != null ? puzzleStatus() : this.puzzleStatus,
      highlightedBlocks: highlightedBlocks != null
          ? highlightedBlocks()
          : this.highlightedBlocks,
      selectedBlock:
          selectedBlock != null ? selectedBlock() : this.selectedBlock,
    );
  }
}
