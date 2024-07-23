// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file

part of 'puzzle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Puzzle _$PuzzleFromJson(Map<String, dynamic> json) => Puzzle(
      sudoku: Sudoku.fromJson(json['sudoku'] as Map<String, dynamic>),
      difficulty: $enumDecode(_$DifficultyEnumMap, json['difficulty']),
      totalSecondsElapsed: (json['totalSecondsElapsed'] as num?)?.toInt() ?? 0,
      remainingMistakes: (json['remainingMistakes'] as num?)?.toInt() ?? 3,
      remainingHints: (json['remainingHints'] as num?)?.toInt() ?? 3,
    );

Map<String, dynamic> _$PuzzleToJson(Puzzle instance) => <String, dynamic>{
      'sudoku': instance.sudoku.toJson(),
      'difficulty': _$DifficultyEnumMap[instance.difficulty]!,
      'totalSecondsElapsed': instance.totalSecondsElapsed,
      'remainingMistakes': instance.remainingMistakes,
      'remainingHints': instance.remainingHints,
    };

const _$DifficultyEnumMap = {
  Difficulty.easy: 'easy',
  Difficulty.medium: 'medium',
  Difficulty.difficult: 'difficult',
  Difficulty.expert: 'expert',
};
