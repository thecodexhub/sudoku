// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file

part of 'generate_hint_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenerateHintRequestDto _$GenerateHintRequestDtoFromJson(
        Map<String, dynamic> json) =>
    GenerateHintRequestDto(
      data: GenerateHintRequest.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GenerateHintRequestDtoToJson(
        GenerateHintRequestDto instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
    };

GenerateHintRequest _$GenerateHintRequestFromJson(Map<String, dynamic> json) =>
    GenerateHintRequest(
      puzzle: (json['puzzle'] as List<dynamic>)
          .map((e) =>
              (e as List<dynamic>).map((e) => (e as num).toInt()).toList())
          .toList(),
      solution: (json['solution'] as List<dynamic>)
          .map((e) =>
              (e as List<dynamic>).map((e) => (e as num).toInt()).toList())
          .toList(),
    );

Map<String, dynamic> _$GenerateHintRequestToJson(
        GenerateHintRequest instance) =>
    <String, dynamic>{
      'puzzle': instance.puzzle,
      'solution': instance.solution,
    };
