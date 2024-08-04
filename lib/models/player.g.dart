// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) => Player(
      name: json['name'] as String? ?? '',
      easyAttempted: (json['easy_attempted'] as num?)?.toInt() ?? 0,
      easySolved: (json['easy_solved'] as num?)?.toInt() ?? 0,
      mediumAttempted: (json['medium_attempted'] as num?)?.toInt() ?? 0,
      mediumSolved: (json['medium_solved'] as num?)?.toInt() ?? 0,
      difficultAttempted: (json['difficult_attempted'] as num?)?.toInt() ?? 0,
      difficultSolved: (json['difficult_solved'] as num?)?.toInt() ?? 0,
      expertAttempted: (json['expert_attempted'] as num?)?.toInt() ?? 0,
      expertSolved: (json['expert_solved'] as num?)?.toInt() ?? 0,
      totalAttempted: (json['total_attempted'] as num?)?.toInt() ?? 0,
      totalSolved: (json['total_solved'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'name': instance.name,
      'easy_attempted': instance.easyAttempted,
      'easy_solved': instance.easySolved,
      'medium_attempted': instance.mediumAttempted,
      'medium_solved': instance.mediumSolved,
      'difficult_attempted': instance.difficultAttempted,
      'difficult_solved': instance.difficultSolved,
      'expert_attempted': instance.expertAttempted,
      'expert_solved': instance.expertSolved,
      'total_attempted': instance.totalAttempted,
      'total_solved': instance.totalSolved,
    };
