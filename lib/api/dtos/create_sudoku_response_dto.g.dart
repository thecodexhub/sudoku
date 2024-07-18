// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file

part of 'create_sudoku_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateSudokuResponseDto _$CreateSudokuResponseDtoFromJson(
        Map<String, dynamic> json) =>
    CreateSudokuResponseDto(
      result:
          CreateSudokuResponse.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateSudokuResponseDtoToJson(
        CreateSudokuResponseDto instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

CreateSudokuResponse _$CreateSudokuResponseFromJson(
        Map<String, dynamic> json) =>
    CreateSudokuResponse(
      puzzle: (json['puzzle'] as List<dynamic>)
          .map((e) =>
              (e as List<dynamic>).map((e) => (e as num).toInt()).toList())
          .toList(),
      solution: (json['solution'] as List<dynamic>)
          .map((e) =>
              (e as List<dynamic>).map((e) => (e as num).toInt()).toList())
          .toList(),
    );

Map<String, dynamic> _$CreateSudokuResponseToJson(
        CreateSudokuResponse instance) =>
    <String, dynamic>{
      'puzzle': instance.puzzle,
      'solution': instance.solution,
    };
