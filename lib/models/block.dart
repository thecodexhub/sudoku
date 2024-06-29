import 'package:equatable/equatable.dart';
import 'package:sudoku/models/models.dart';

/// {@template block}
/// Model for a sudoku block.
/// {@endtemplate}
class Block extends Equatable {
  /// {@macro block}
  const Block({
    required this.position,
    required this.correctValue,
    required this.currentValue,
    this.isGenerated = false,
  });

  /// The 2D [Position] of the [Block].
  final Position position;

  /// The correct value of the [Block].
  final int correctValue;

  /// The current value of the [Block]. If this block
  /// is generated during initialization of the puzzle,
  /// this value will be -1.
  final int currentValue;

  /// Whether or not this block was generated with a value
  /// during initialization.
  final bool isGenerated;

  /// Create a copy of this [Block] with updated current value.
  Block copyWith({required int currentValue}) {
    return Block(
      position: position,
      correctValue: correctValue,
      currentValue: currentValue,
      isGenerated: isGenerated,
    );
  }

  @override
  List<Object?> get props => [
        position,
        correctValue,
        currentValue,
        isGenerated,
      ];
}
