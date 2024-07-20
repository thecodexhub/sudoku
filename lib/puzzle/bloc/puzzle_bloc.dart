import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/puzzle/puzzle.dart';

part 'puzzle_event.dart';
part 'puzzle_state.dart';

class PuzzleBloc extends Bloc<PuzzleEvent, PuzzleState> {
  PuzzleBloc({
    required PuzzleRepository puzzleRepository,
  })  : _puzzleRepository = puzzleRepository,
        super(const PuzzleState()) {
    on<PuzzleInitialized>(_onPuzzleInitialized);
    on<SudokuBlockSelected>(_onSudokuBlockSelected);
    on<SudokuInputEntered>(_onSudokuInputEntered);
    on<SudokuInputErased>(_onSudokuInputErased);
  }

  final PuzzleRepository _puzzleRepository;

  void _onPuzzleInitialized(
    PuzzleInitialized event,
    Emitter<PuzzleState> emit,
  ) {
    final puzzle = _puzzleRepository.getPuzzle()!;
    emit(state.copyWith(puzzle: () => puzzle));
  }

  void _onSudokuBlockSelected(
    SudokuBlockSelected event,
    Emitter<PuzzleState> emit,
  ) {
    emit(
      state.copyWith(
        selectedBlock: () => event.block,
        highlightedBlocks: () =>
            state.puzzle.sudoku.blocksToHighlight(event.block),
      ),
    );
  }

  void _onSudokuInputEntered(
    SudokuInputEntered event,
    Emitter<PuzzleState> emit,
  ) {
    final selectedBlock = state.selectedBlock;
    if (selectedBlock == null || selectedBlock.isGenerated == true) return;

    final mutableSudoku = Sudoku(
      blocks: [...state.puzzle.sudoku.blocks],
    );

    final updatedSudoku = mutableSudoku.updateBlock(
      selectedBlock,
      event.input,
    );

    // If the entered input is wrong.
    if (selectedBlock.correctValue != event.input) {
      final remainingMistakes = state.puzzle.remainingMistakes - 1;
      // If there are no more remaining mistakes
      if (remainingMistakes <= 0) {
        emit(
          state.copyWith(
            puzzle: () => state.puzzle.copyWith(
              sudoku: updatedSudoku,
              remainingMistakes: remainingMistakes,
            ),
            puzzleStatus: () => PuzzleStatus.failed,
          ),
        );
      } else {
        emit(
          state.copyWith(
            puzzle: () => state.puzzle.copyWith(
              sudoku: updatedSudoku,
              remainingMistakes: remainingMistakes,
            ),
          ),
        );
      }
    } else if (updatedSudoku.isComplete()) {
      emit(
        state.copyWith(
          puzzle: () => state.puzzle.copyWith(
            sudoku: updatedSudoku,
          ),
          puzzleStatus: () => PuzzleStatus.complete,
          highlightedBlocks: () => const [],
          selectedBlock: () => null,
        ),
      );
    } else {
      emit(
        state.copyWith(
          puzzle: () => state.puzzle.copyWith(
            sudoku: updatedSudoku,
          ),
        ),
      );
    }
  }

  void _onSudokuInputErased(
    SudokuInputErased event,
    Emitter<PuzzleState> emit,
  ) {
    final selectedBlock = state.selectedBlock;
    if (selectedBlock == null || selectedBlock.isGenerated == true) return;

    final mutableSudoku = Sudoku(
      blocks: [...state.puzzle.sudoku.blocks],
    );

    emit(
      state.copyWith(
        puzzle: () => state.puzzle.copyWith(
          sudoku: mutableSudoku.updateBlock(selectedBlock, -1),
        ),
      ),
    );
  }
}
