// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file

part of 'block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Block _$BlockFromJson(Map<String, dynamic> json) => Block(
      position: Position.fromJson(json['position'] as Map<String, dynamic>),
      correctValue: (json['correctValue'] as num).toInt(),
      currentValue: (json['currentValue'] as num).toInt(),
      isGenerated: json['isGenerated'] as bool? ?? false,
    );

Map<String, dynamic> _$BlockToJson(Block instance) => <String, dynamic>{
      'position': instance.position.toJson(),
      'correctValue': instance.correctValue,
      'currentValue': instance.currentValue,
      'isGenerated': instance.isGenerated,
    };
