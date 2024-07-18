// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file

part of 'create_sudoku_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateSudokuRequestDto _$CreateSudokuRequestDtoFromJson(
        Map<String, dynamic> json) =>
    CreateSudokuRequestDto(
      data: CreateSudokuRequest.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateSudokuRequestDtoToJson(
        CreateSudokuRequestDto instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

CreateSudokuRequest _$CreateSudokuRequestFromJson(Map<String, dynamic> json) =>
    CreateSudokuRequest(
      difficulty: json['difficulty'] as String,
    );

Map<String, dynamic> _$CreateSudokuRequestToJson(
        CreateSudokuRequest instance) =>
    <String, dynamic>{
      'difficulty': instance.difficulty,
    };
