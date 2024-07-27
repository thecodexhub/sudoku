import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generate_hint_request_dto.g.dart';

/// {@template generate_hint_request_dto}
/// A DTO to send [GenerateHintRequest] object wrapped within `data`
/// for the generate hint http request.
/// {@endtemplate}
@immutable
@JsonSerializable(explicitToJson: true)
class GenerateHintRequestDto extends Equatable {
  /// {@macro generate_hint_request_dto}
  const GenerateHintRequestDto({
    required this.data,
  });

  /// The data to be sent over via http.
  final GenerateHintRequest data;

  /// Converts [GenerateHintRequestDto] into [Map].
  Map<String, dynamic> toJson() => _$GenerateHintRequestDtoToJson(this);

  @override
  List<Object?> get props => [data];
}

/// {@template generate_hint_request}
/// Model for the generate hint http request.
/// {@endtemplate}
@immutable
@JsonSerializable()
class GenerateHintRequest extends Equatable {
  /// {@macro generate_hint_request}
  const GenerateHintRequest({
    required this.puzzle,
    required this.solution,
  });

  /// Converts a [Map] object to a [GenerateHintRequest] instance.
  factory GenerateHintRequest.fromJson(Map<String, dynamic> json) =>
      _$GenerateHintRequestFromJson(json);

  /// Current state of the puzzle.
  final List<List<int>> puzzle;

  /// Solution of the puzzle.
  final List<List<int>> solution;

  /// Converts [GenerateHintRequest] into [Map].
  Map<String, dynamic> toJson() => _$GenerateHintRequestToJson(this);

  @override
  List<Object?> get props => [puzzle, solution];
}
