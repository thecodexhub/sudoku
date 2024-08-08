import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku/colors/colors.dart';
import 'package:sudoku/layout/layout.dart';
import 'package:sudoku/puzzle/puzzle.dart';
import 'package:sudoku/sudoku/sudoku.dart';
import 'package:sudoku/typography/typography.dart';

/// {@template sudoku_input}
/// The input blocks for the Sudoku puzzle.
/// {@endtemplate}
class SudokuInput extends StatelessWidget {
  /// {@macro sudoku_input}
  const SudokuInput({
    required this.sudokuDimension,
    super.key,
  });

  /// Dimension of the Sudoku puzzle.
  final int sudokuDimension;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      small: (_, __) => SizedBox.fromSize(
        key: const Key('sudoku_input_small'),
        size: Size(
          SudokuInputSize.small * (sudokuDimension / 2).ceil(),
          SudokuInputSize.small * 2,
        ),
        child: _SudokuInputView(
          sudokuDimension: sudokuDimension,
          inputsPerRow: (sudokuDimension / 2).ceil(),
          inputSize: SudokuInputSize.small,
        ),
      ),
      medium: (_, __) => SizedBox.fromSize(
        key: const Key('sudoku_input_medium'),
        size: Size(
          SudokuInputSize.medium * (sudokuDimension / 2).ceil(),
          SudokuInputSize.medium * 2,
        ),
        child: _SudokuInputView(
          sudokuDimension: sudokuDimension,
          inputsPerRow: (sudokuDimension / 2).ceil(),
          inputSize: SudokuInputSize.medium,
        ),
      ),
      large: (_, __) => SizedBox.fromSize(
        key: const Key('sudoku_input_large'),
        size: Size(
          SudokuInputSize.large * (sudokuDimension / 3).ceil(),
          SudokuInputSize.large * 3,
        ),
        child: _SudokuInputView(
          sudokuDimension: sudokuDimension,
          inputsPerRow: (sudokuDimension / 3).ceil(),
          inputSize: SudokuInputSize.large,
          showEraserInSameLine: false,
        ),
      ),
    );
  }
}

class _SudokuInputView extends StatelessWidget {
  const _SudokuInputView({
    required this.sudokuDimension,
    required this.inputsPerRow,
    required this.inputSize,
    this.showEraserInSameLine = true,
  });

  final int sudokuDimension;
  final int inputsPerRow;
  final double inputSize;
  final bool showEraserInSameLine;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final keySize = switch (inputSize) {
      SudokuInputSize.small => 'small',
      SudokuInputSize.medium => 'medium',
      SudokuInputSize.large => 'large',
      _ => 'other',
    };

    final elementsCount =
        showEraserInSameLine ? sudokuDimension + 1 : sudokuDimension;

    return Stack(
      children: [
        for (var i = 0; i < elementsCount; i++)
          Positioned(
            top: (i ~/ inputsPerRow) * inputSize,
            left: (i % inputsPerRow) * inputSize,
            child: GestureDetector(
              onTap: () => showEraserInSameLine && i == elementsCount - 1
                  ? context.read<PuzzleBloc>().add(const SudokuInputErased())
                  : context.read<PuzzleBloc>().add(SudokuInputEntered(i + 1)),
              child: Container(
                key: Key('sudoku_input_${keySize}_block_${i + 1}'),
                alignment: Alignment.center,
                margin: const EdgeInsets.all(8),
                height: inputSize - 16,
                width: inputSize - 16,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: showEraserInSameLine && i == elementsCount - 1
                        ? Colors.transparent
                        : theme.dividerColor,
                    width: 1.4,
                  ),
                  gradient: showEraserInSameLine && i == elementsCount - 1
                      ? LinearGradient(
                          colors: [
                            SudokuColors.getPurple(context),
                            SudokuColors.getPink(context),
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        )
                      : null,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  showEraserInSameLine && i == elementsCount - 1
                      ? 'X'
                      : '${i + 1}',
                  style: SudokuTextStyle.headline6.copyWith(
                    color: showEraserInSameLine && i == elementsCount - 1
                        ? Colors.white
                        : theme.colorScheme.secondary,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
