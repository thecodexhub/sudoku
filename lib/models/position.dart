import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sudoku/models/models.dart';

part 'position.g.dart';

/// {@template position}
/// 2-dimensional position model.
///
/// (0, 0) means the top-left corner of the Sudoku board.
/// {@endtemplate}
@immutable
@JsonSerializable(explicitToJson: true)
class Position extends Equatable implements Comparable<Position> {
  /// {@macro position}
  const Position({required this.x, required this.y});

  /// The x position.
  final int x;

  /// The y position.
  final int y;

  /// Deserializes the given [JsonMap] into a [Position].
  static Position fromJson(JsonMap json) => _$PositionFromJson(json);

  /// Converts this [Position] into a [JsonMap].
  JsonMap toJson() => _$PositionToJson(this);

  @override
  int compareTo(covariant Position other) {
    if (y < other.y) {
      return -1;
    } else if (y > other.y) {
      return 1;
    } else {
      if (x < other.x) {
        return -1;
      } else if (x > other.x) {
        return 1;
      } else {
        return 0;
      }
    }
  }

  @override
  List<Object?> get props => [x, y];
}
