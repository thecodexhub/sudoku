import 'package:equatable/equatable.dart';

/// {@template position}
/// 2-dimensional position model.
///
/// (0, 0) means the top-left corner of the Sudoku board.
/// {@endtemplate}
class Position extends Equatable implements Comparable<Position> {
  /// {@macro position}
  const Position({required this.x, required this.y});

  /// The x position.
  final int x;

  /// The y position.
  final int y;

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
