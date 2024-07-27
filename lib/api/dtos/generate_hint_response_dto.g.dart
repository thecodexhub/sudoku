// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file

part of 'generate_hint_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenerateHintResponseDto _$GenerateHintResponseDtoFromJson(
        Map<String, dynamic> json) =>
    GenerateHintResponseDto(
      result:
          GenerateHintResponse.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GenerateHintResponseDtoToJson(
        GenerateHintResponseDto instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

GenerateHintResponse _$GenerateHintResponseFromJson(
        Map<String, dynamic> json) =>
    GenerateHintResponse(
      cell: (json['cell'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      entry: (json['entry'] as num).toInt(),
      observation: json['observation'] as String,
      explanation: json['explanation'] as String,
      solution: json['solution'] as String,
    );

Map<String, dynamic> _$GenerateHintResponseToJson(
        GenerateHintResponse instance) =>
    <String, dynamic>{
      'cell': instance.cell,
      'entry': instance.entry,
      'observation': instance.observation,
      'explanation': instance.explanation,
      'solution': instance.solution,
    };
