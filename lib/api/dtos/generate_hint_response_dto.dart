import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sudoku/models/models.dart';

part 'generate_hint_response_dto.g.dart';

/// {@template generate_hint_response_dto}
/// A DTO to receive [GenerateHintResponse] object wrapped within `data`
/// from the generate hint http request.
/// {@endtemplate}
@immutable
@JsonSerializable()
class GenerateHintResponseDto extends Equatable {
  /// {@macro generate_hint_response_dto}
  const GenerateHintResponseDto({
    required this.result,
  });

  /// Converts a [Map] json into a [GenerateHintResponseDto] instance.
  factory GenerateHintResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GenerateHintResponseDtoFromJson(json);

  /// The result to be received over via http.
  final GenerateHintResponse result;

  @override
  List<Object?> get props => [result];
}

/// {@template generate_hint_response}
/// Model for the generate hint http response.
/// {@endtemplate}
@immutable
@JsonSerializable()
class GenerateHintResponse extends Equatable {
  /// {@macro generate_hint_response}
  const GenerateHintResponse({
    required this.cell,
    required this.entry,
    required this.observation,
    required this.explanation,
    required this.solution,
  });

  /// Converts a [Map] into a [GenerateHintResponse] instance.
  factory GenerateHintResponse.fromJson(Map<String, dynamic> json) =>
      _$GenerateHintResponseFromJson(json);

  /// The position of the cell.
  final List<int> cell;

  /// The number to be put in the cell.
  final int entry;

  /// The observation of the puzzle state for solving the cell.
  final String observation;

  /// Explanation of the puzzle, and how to determine the solution.
  final String explanation;

  /// The solution of the puzzle in a sentence.
  final String solution;

  /// Converts the [GenerateHintResponse] to [Hint].
  Hint toHint() {
    return Hint(
      cell: Position(x: cell[0], y: cell[1]),
      entry: entry,
      observation: observation,
      explanation: explanation,
      solution: solution,
    );
  }

  @override
  List<Object?> get props => [
        cell,
        entry,
        observation,
        explanation,
        solution,
      ];
}
