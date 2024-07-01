import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sudoku/models/models.dart';

part 'sudoku_event.dart';
part 'sudoku_state.dart';

class SudokuBloc extends Bloc<SudokuEvent, SudokuState> {
  SudokuBloc({required Sudoku sudoku}) : super(SudokuState(sudoku: sudoku)) {
    on<SudokuBlockSelected>(_onBlockSelected);
    on<SudokuInputTapped>(_onInputTapped);
  }

  void _onBlockSelected(SudokuBlockSelected event, Emitter<SudokuState> emit) {
    if (event.block.isGenerated) {
      emit(
        state.copyWith(
          blockSelectionStatus: () => BlockSelectionStatus.cannotBeSelected,
          currentSelectedBlock: () => null,
          highlightedBlocks: () => {},
        ),
      );
    } else {
      final subGridBlocks = state.sudoku.getSubGridBlocks(event.block);
      final rowBlocks = state.sudoku.getRowBlocks(event.block);
      final columnBlocks = state.sudoku.getColumnBlocks(event.block);

      final highlightedBlocks = [
        ...subGridBlocks,
        ...rowBlocks,
        ...columnBlocks,
      ];

      emit(
        state.copyWith(
          blockSelectionStatus: () => BlockSelectionStatus.selected,
          currentSelectedBlock: () => event.block,
          highlightedBlocks: highlightedBlocks.toSet,
        ),
      );
    }
  }

  void _onInputTapped(SudokuInputTapped event, Emitter<SudokuState> emit) {
    if (state.currentSelectedBlock == null) return;

    final mutableSudoku = Sudoku(blocks: [...state.sudoku.blocks]);
    final blockToUpdate = state.currentSelectedBlock!;

    final sudoku = mutableSudoku.updateBlock(blockToUpdate, event.input);

    if (sudoku.isComplete()) {
      emit(
        state.copyWith(
          puzzleStatus: () => SudokuPuzzleStatus.complete,
          sudoku: () => sudoku,
        ),
      );
    } else {
      emit(
        state.copyWith(sudoku: () => sudoku),
      );
    }
  }
}
