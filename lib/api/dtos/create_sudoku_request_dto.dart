import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_sudoku_request_dto.g.dart';

/// {@template create_sudoku_request_dto}
/// A DTO to send [CreateSudokuRequest] object wrapped within `data`
/// for the create sudoku http request.
/// {@endtemplate}
@immutable
@JsonSerializable(explicitToJson: true)
class CreateSudokuRequestDto extends Equatable {
  /// {@macro create_sudoku_request_dto}
  const CreateSudokuRequestDto({
    required this.data,
  });

  /// The data to be sent over via http.
  final CreateSudokuRequest data;

  /// Converts [CreateSudokuRequestDto] into [Map].
  Map<String, dynamic> toJson() => _$CreateSudokuRequestDtoToJson(this);

  @override
  List<Object?> get props => [data];
}

/// {@template create_sudoku_request}
/// Model for the create sudoku http request.
/// {@endtemplate}
@immutable
@JsonSerializable()
class CreateSudokuRequest extends Equatable {
  /// {@macro create_sudoku_request}
  const CreateSudokuRequest({
    required this.difficulty,
  });

  /// Converts a [Map] object to a [CreateSudokuRequest] instance.
  factory CreateSudokuRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateSudokuRequestFromJson(json);

  /// Difficulty level of the sudoku.
  final String difficulty;

  /// Converts [CreateSudokuRequest] into [Map].
  Map<String, dynamic> toJson() => _$CreateSudokuRequestToJson(this);

  @override
  List<Object?> get props => [difficulty];
}
