// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sudoku/models/models.dart';

part 'puzzle.g.dart';

/// {@template puzzle}
/// Defines the model for a [Sudoku] puzzle.
/// {@endtemplate}
@immutable
@JsonSerializable(explicitToJson: true)
class Puzzle extends Equatable {
  /// {@macro puzzle}
  const Puzzle({
    required this.sudoku,
    required this.difficulty,
    this.totalSecondsElapsed = 0,
    this.remainingMistakes = 3,
    this.remainingHints = 3,
  });

  /// Sudoku for this puzzle.
  final Sudoku sudoku;

  /// The difficulty of the puzzle.
  final Difficulty difficulty;

  /// Total seconds elapsed on this game.
  ///
  /// Default is set to 0.
  final int totalSecondsElapsed;

  /// Defines the remaining mistakes available for this sudoku.
  ///
  /// Default is set to 3.
  final int remainingMistakes;

  /// Defines the remaining hints available for this puzzle.
  ///
  /// Defaults to 3.
  final int remainingHints;

  /// Deserializes the given [JsonMap] into a [Puzzle].
  static Puzzle fromJson(JsonMap json) => _$PuzzleFromJson(json);

  /// Converts this [Puzzle] into a [JsonMap].
  JsonMap toJson() => _$PuzzleToJson(this);

  @override
  List<Object?> get props => [
        sudoku,
        difficulty,
        totalSecondsElapsed,
        remainingMistakes,
        remainingHints,
      ];

  /// Returns an updated copy of this [Puzzle] with the
  /// updated parameters.
  ///
  /// {@macro puzzle}
  Puzzle copyWith({
    Sudoku? sudoku,
    Difficulty? difficulty,
    int? totalSecondsElapsed,
    int? remainingMistakes,
    int? remainingHints,
  }) {
    return Puzzle(
      sudoku: sudoku ?? this.sudoku,
      difficulty: difficulty ?? this.difficulty,
      totalSecondsElapsed: totalSecondsElapsed ?? this.totalSecondsElapsed,
      remainingMistakes: remainingMistakes ?? this.remainingMistakes,
      remainingHints: remainingHints ?? this.remainingHints,
    );
  }
}
