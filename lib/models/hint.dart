import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:sudoku/models/models.dart';

/// {@template hint}
/// Model for a sudoku puzzle hint.
/// {@endtemplate}
@immutable
class Hint extends Equatable {
  /// {@macro hint}
  const Hint({
    required this.cell,
    required this.entry,
    required this.observation,
    required this.explanation,
    required this.solution,
  });

  /// Defines the position or the cell for the hint.
  final Position cell;

  /// The number to be put in the cell.
  final int entry;

  /// The observation of the puzzle state for solving the cell.
  final String observation;

  /// Explanation of the puzzle, and how to determine the solution.
  final String explanation;

  /// The solution of the puzzle in a sentence.
  final String solution;

  @override
  List<Object?> get props => [
        cell,
        entry,
        observation,
        explanation,
        solution,
      ];
}
