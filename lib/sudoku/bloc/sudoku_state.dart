// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sudoku_bloc.dart';

enum SudokuPuzzleStatus { incomplete, complete }

enum BlockSelectionStatus { nothingSelected, cannotBeSelected, selected }

class SudokuState extends Equatable {
  const SudokuState({
    required this.sudoku,
    this.puzzleStatus = SudokuPuzzleStatus.incomplete,
    this.blockSelectionStatus = BlockSelectionStatus.nothingSelected,
    this.highlightedBlocks = const <Block>{},
    this.currentSelectedBlock,
  });

  final Sudoku sudoku;
  final SudokuPuzzleStatus puzzleStatus;
  final BlockSelectionStatus blockSelectionStatus;
  final Set<Block> highlightedBlocks;
  final Block? currentSelectedBlock;

  @override
  List<Object?> get props => [
        sudoku,
        puzzleStatus,
        blockSelectionStatus,
        highlightedBlocks,
        currentSelectedBlock,
      ];

  SudokuState copyWith({
    Sudoku Function()? sudoku,
    SudokuPuzzleStatus Function()? puzzleStatus,
    BlockSelectionStatus Function()? blockSelectionStatus,
    Set<Block> Function()? highlightedBlocks,
    Block? Function()? currentSelectedBlock,
  }) {
    return SudokuState(
      sudoku: sudoku != null ? sudoku() : this.sudoku,
      puzzleStatus: puzzleStatus != null ? puzzleStatus() : this.puzzleStatus,
      blockSelectionStatus: blockSelectionStatus != null
          ? blockSelectionStatus()
          : this.blockSelectionStatus,
      highlightedBlocks: highlightedBlocks != null
          ? highlightedBlocks()
          : this.highlightedBlocks,
      currentSelectedBlock: currentSelectedBlock != null
          ? currentSelectedBlock()
          : this.currentSelectedBlock,
    );
  }
}
