import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_sudoku_response_dto.g.dart';

/// {@template create_sudoku_response_dto}
/// A DTO to receive [CreateSudokuResponse] object wrapped within `data`
/// from the create sudoku http request.
/// {@endtemplate}
@immutable
@JsonSerializable()
class CreateSudokuResponseDto extends Equatable {
  /// {@macro create_sudoku_response_dto}
  const CreateSudokuResponseDto({
    required this.result,
  });

  /// Converts a [Map] json into a [CreateSudokuResponseDto] instance.
  factory CreateSudokuResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CreateSudokuResponseDtoFromJson(json);

  /// The result to be received over via http.
  final CreateSudokuResponse result;

  @override
  List<Object?> get props => [result];
}

/// {@template create_sudoku_response}
/// Model for the create sudoku http response.
/// {@endtemplate}
@immutable
@JsonSerializable()
class CreateSudokuResponse extends Equatable {
  const CreateSudokuResponse({
    required this.puzzle,
    required this.solution,
  });

  /// Converts a [Map] into a [CreateSudokuResponse] instance.
  factory CreateSudokuResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateSudokuResponseFromJson(json);

  /// Puzzle for the sudoku game.
  final List<List<int>> puzzle;

  /// The completed state or the solution of the sudoku.
  final List<List<int>> solution;

  @override
  List<Object?> get props => [puzzle, solution];
}
