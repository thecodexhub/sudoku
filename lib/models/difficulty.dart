import 'package:json_annotation/json_annotation.dart';

/// Defines the sudoku difficulty level
@JsonEnum()
enum Difficulty {
  /// Easy level
  easy,

  /// Medium level
  medium,

  /// Difficult level
  difficult,

  /// Expert level
  expert
}
