// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file

part of 'sudoku.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sudoku _$SudokuFromJson(Map<String, dynamic> json) => Sudoku(
      blocks: (json['blocks'] as List<dynamic>)
          .map((e) => Block.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SudokuToJson(Sudoku instance) => <String, dynamic>{
      'blocks': instance.blocks.map((e) => e.toJson()).toList(),
    };
