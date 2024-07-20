// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/puzzle/puzzle.dart';

import '../../helpers/helpers.dart';

class _FakeBlock extends Fake implements Block {}

void main() {
  group('PuzzleBloc', () {
    late Block block;
    late Sudoku sudoku;
    late Puzzle puzzle;
    late PuzzleRepository repository;

    setUp(() {
      block = MockBlock();
      sudoku = MockSudoku();
      puzzle = MockPuzzle();
      repository = MockPuzzleRepository();

      when(() => sudoku.blocksToHighlight(any())).thenReturn([block]);
      when(() => puzzle.sudoku).thenReturn(sudoku);
      when(() => repository.getPuzzle()).thenReturn(puzzle);
    });

    setUpAll(() {
      registerFallbackValue(_FakeBlock());
    });

    PuzzleBloc buildBloc() {
      return PuzzleBloc(puzzleRepository: repository);
    }

    test('constructor works correctly', () {
      expect(buildBloc, returnsNormally);
    });

    test('has an initial state', () {
      expect(buildBloc().state, equals(PuzzleState()));
    });

    group('PuzzleInitialized', () {
      blocTest<PuzzleBloc, PuzzleState>(
        'emits new state with updated puzzle from the repository',
        build: buildBloc,
        act: (bloc) => bloc.add(PuzzleInitialized()),
        expect: () => [
          PuzzleState(puzzle: puzzle),
        ],
        verify: (_) {
          verify(() => repository.getPuzzle()).called(1);
        },
      );
    });

    group('SudokuBlockSelected', () {
      blocTest<PuzzleBloc, PuzzleState>(
        'emits state with updated [selectedBlock], and [highlightedBlocks]',
        build: buildBloc,
        seed: () => PuzzleState(puzzle: puzzle),
        act: (bloc) => bloc.add(SudokuBlockSelected(block)),
        expect: () => [
          PuzzleState(
            puzzle: puzzle,
            selectedBlock: block,
            highlightedBlocks: [block],
          ),
        ],
        verify: (_) {
          verify(() => sudoku.blocksToHighlight(block)).called(1);
        },
      );
    });

    group('SudokuInputEntered', () {
      late Block generatedBlock;
      late Puzzle puzzleWithOneMistake;
      late Puzzle puzzleWithOneRemainingBlock;

      setUp(() {
        generatedBlock = sudoku2x2Block1;
        block = sudoku2x2Block2;
        puzzle = Puzzle(sudoku: sudoku2x2, difficulty: Difficulty.medium);
        puzzleWithOneMistake = puzzle.copyWith(remainingMistakes: 1);
        puzzleWithOneRemainingBlock = puzzle.copyWith(
          sudoku: sudoku2x2WithOneRemaining,
        );
      });

      blocTest<PuzzleBloc, PuzzleState>(
        'does not emit state if the selected block is null',
        build: buildBloc,
        seed: () => PuzzleState(puzzle: puzzle, selectedBlock: null),
        act: (bloc) => bloc.add(SudokuInputEntered(3)),
        expect: () => <PuzzleState>[],
      );

      blocTest<PuzzleBloc, PuzzleState>(
        'does not emit state if the selected block is generated',
        build: buildBloc,
        seed: () => PuzzleState(puzzle: puzzle, selectedBlock: generatedBlock),
        act: (bloc) => bloc.add(SudokuInputEntered(3)),
        expect: () => <PuzzleState>[],
      );

      blocTest<PuzzleBloc, PuzzleState>(
        'emits updated sudoku, and failed [PuzzleStatus] if the remaining '
        'mistake becomes 0',
        build: buildBloc,
        seed: () => PuzzleState(
          puzzle: puzzleWithOneMistake,
          selectedBlock: block,
        ),
        act: (bloc) => bloc.add(SudokuInputEntered(3)),
        expect: () => <PuzzleState>[
          PuzzleState(
            puzzle: puzzleWithOneMistake.copyWith(
              sudoku: puzzle.sudoku.updateBlock(block, 3),
              remainingMistakes: 0,
            ),
            puzzleStatus: PuzzleStatus.failed,
            selectedBlock: block,
          ),
        ],
      );

      blocTest<PuzzleBloc, PuzzleState>(
        'emits updated sudoku, and failed [PuzzleStatus] if the remaining '
        'mistake becomes 0 after wrong input',
        build: buildBloc,
        seed: () => PuzzleState(
          puzzle: puzzleWithOneMistake,
          selectedBlock: block,
        ),
        act: (bloc) => bloc.add(SudokuInputEntered(3)),
        expect: () => <PuzzleState>[
          PuzzleState(
            puzzle: puzzleWithOneMistake.copyWith(
              sudoku: puzzle.sudoku.updateBlock(block, 3),
              remainingMistakes: 0,
            ),
            puzzleStatus: PuzzleStatus.failed,
            selectedBlock: block,
          ),
        ],
      );

      blocTest<PuzzleBloc, PuzzleState>(
        'emits updated sudoku, and remaining mistake decreases '
        'after wrong input',
        build: buildBloc,
        seed: () => PuzzleState(
          puzzle: puzzle,
          selectedBlock: block,
        ),
        act: (bloc) => bloc.add(SudokuInputEntered(3)),
        expect: () => <PuzzleState>[
          PuzzleState(
            puzzle: puzzle.copyWith(
              sudoku: puzzle.sudoku.updateBlock(block, 3),
              remainingMistakes: 2,
            ),
            selectedBlock: block,
          ),
        ],
      );

      blocTest<PuzzleBloc, PuzzleState>(
        'emits updated sudoku, and completed [PuzzleStatus] if the input '
        'is correct and puzzle is complete',
        build: buildBloc,
        seed: () => PuzzleState(
          puzzle: puzzleWithOneRemainingBlock,
          selectedBlock: block,
        ),
        act: (bloc) => bloc.add(SudokuInputEntered(2)),
        expect: () => <PuzzleState>[
          PuzzleState(
            puzzle: puzzleWithOneRemainingBlock.copyWith(
              sudoku: puzzleWithOneRemainingBlock.sudoku.updateBlock(block, 2),
            ),
            puzzleStatus: PuzzleStatus.complete,
            selectedBlock: null,
          ),
        ],
      );

      blocTest<PuzzleBloc, PuzzleState>(
        'emits updated sudoku when correct input is entered',
        build: buildBloc,
        seed: () => PuzzleState(
          puzzle: puzzle,
          selectedBlock: block,
        ),
        act: (bloc) => bloc.add(SudokuInputEntered(2)),
        expect: () => <PuzzleState>[
          PuzzleState(
            puzzle: puzzle.copyWith(
              sudoku: puzzle.sudoku.updateBlock(block, 2),
            ),
            selectedBlock: block,
          ),
        ],
      );
    });

    group('SudokuInputErased', () {
      late Block generatedBlock;

      setUp(() {
        generatedBlock = sudoku2x2Block1;
        block = sudoku2x2Block2.copyWith(currentValue: 2);
        puzzle = Puzzle(sudoku: sudoku2x2, difficulty: Difficulty.medium);
      });

      blocTest<PuzzleBloc, PuzzleState>(
        'does not emit state if the selected block is null',
        build: buildBloc,
        seed: () => PuzzleState(puzzle: puzzle, selectedBlock: null),
        act: (bloc) => bloc.add(SudokuInputErased()),
        expect: () => <PuzzleState>[],
      );

      blocTest<PuzzleBloc, PuzzleState>(
        'does not emit state if the selected block is generated',
        build: buildBloc,
        seed: () => PuzzleState(puzzle: puzzle, selectedBlock: generatedBlock),
        act: (bloc) => bloc.add(SudokuInputErased()),
        expect: () => <PuzzleState>[],
      );

      blocTest<PuzzleBloc, PuzzleState>(
        'erases the currentValue from selected block',
        build: buildBloc,
        seed: () => PuzzleState(
          puzzle: puzzle.copyWith(
            sudoku: puzzle.sudoku.updateBlock(block, 4),
          ),
          selectedBlock: block.copyWith(currentValue: 4),
        ),
        act: (bloc) => bloc.add(SudokuInputErased()),
        expect: () => [
          PuzzleState(
            puzzle: puzzle,
            selectedBlock: block.copyWith(currentValue: 4),
          ),
        ],
      );
    });
  });
}
