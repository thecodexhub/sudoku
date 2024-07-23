// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file

part of 'position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Position _$PositionFromJson(Map<String, dynamic> json) => Position(
      x: (json['x'] as num).toInt(),
      y: (json['y'] as num).toInt(),
    );

Map<String, dynamic> _$PositionToJson(Position instance) => <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
    };
