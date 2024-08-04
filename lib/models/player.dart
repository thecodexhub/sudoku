// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:json_annotation/json_annotation.dart';
import 'package:sudoku/models/models.dart';

part 'player.g.dart';

/// {@template player}
/// Player model.
/// {@endtemplate}
@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class Player extends Equatable {
  /// {@macro player}
  const Player({
    this.name = '',
    this.easyAttempted = 0,
    this.easySolved = 0,
    this.mediumAttempted = 0,
    this.mediumSolved = 0,
    this.difficultAttempted = 0,
    this.difficultSolved = 0,
    this.expertAttempted = 0,
    this.expertSolved = 0,
    this.totalAttempted = 0,
    this.totalSolved = 0,
  });

  /// Name of the player.
  ///
  /// Defaults to empty-string.
  final String name;

  /// Number of easy puzzles created by the player.
  ///
  /// Defaults to 0.
  final int easyAttempted;

  /// Number of easy puzzles solved by the player.
  ///
  /// Defaults to 0.
  final int easySolved;

  /// Number of medium puzzles created by the player.
  ///
  /// Defaults to 0.
  final int mediumAttempted;

  /// Number of medium puzzles solved by the player.
  ///
  /// Defaults to 0.
  final int mediumSolved;

  /// Number of difficult puzzles created by the player.
  ///
  /// Defaults to 0.
  final int difficultAttempted;

  /// Number of difficult puzzles solved by the player.
  ///
  /// Defaults to 0.
  final int difficultSolved;

  /// Number of expert puzzles created by the player.
  ///
  /// Defaults to 0.
  final int expertAttempted;

  /// Number of expert puzzles solved by the player.
  ///
  /// Defaults to 0.
  final int expertSolved;

  /// Number of total puzzles created by the player.
  ///
  /// Defaults to 0.
  final int totalAttempted;

  /// Number of total puzzles solved by the player.
  ///
  /// Defaults to 0.
  final int totalSolved;

  /// Represents an empty player object.
  static const empty = Player();

  /// Deserializes the given [JsonMap] into a [Player].
  static Player fromJson(JsonMap json) => _$PlayerFromJson(json);

  /// Converts this [Player] into a [JsonMap].
  JsonMap toJson() => _$PlayerToJson(this);

  /// Helper method that increase attempt count depending upon
  /// provided difficulty level.
  Player updateAttemptCount(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.easy:
        return copyWith(
          easyAttempted: easyAttempted + 1,
          totalAttempted: totalAttempted + 1,
        );
      case Difficulty.medium:
        return copyWith(
          mediumAttempted: mediumAttempted + 1,
          totalAttempted: totalAttempted + 1,
        );
      case Difficulty.difficult:
        return copyWith(
          difficultAttempted: difficultAttempted + 1,
          totalAttempted: totalAttempted + 1,
        );
      case Difficulty.expert:
        return copyWith(
          expertAttempted: expertAttempted + 1,
          totalAttempted: totalAttempted + 1,
        );
    }
  }

  /// Helper method that increase solved count depending upon
  /// provided difficulty level.
  Player updateSolvedCount(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.easy:
        return copyWith(
          easySolved: easySolved + 1,
          totalSolved: totalSolved + 1,
        );
      case Difficulty.medium:
        return copyWith(
          mediumSolved: mediumSolved + 1,
          totalSolved: totalSolved + 1,
        );
      case Difficulty.difficult:
        return copyWith(
          difficultSolved: difficultSolved + 1,
          totalSolved: totalSolved + 1,
        );
      case Difficulty.expert:
        return copyWith(
          expertSolved: expertSolved + 1,
          totalSolved: totalSolved + 1,
        );
    }
  }

  /// Returns a new instance of the [Player] with updated value.
  ///
  /// {@macro player}
  Player copyWith({
    String? name,
    int? easyAttempted,
    int? easySolved,
    int? mediumAttempted,
    int? mediumSolved,
    int? difficultAttempted,
    int? difficultSolved,
    int? expertAttempted,
    int? expertSolved,
    int? totalAttempted,
    int? totalSolved,
  }) {
    return Player(
      name: name ?? this.name,
      easyAttempted: easyAttempted ?? this.easyAttempted,
      easySolved: easySolved ?? this.easySolved,
      mediumAttempted: mediumAttempted ?? this.mediumAttempted,
      mediumSolved: mediumSolved ?? this.mediumSolved,
      difficultAttempted: difficultAttempted ?? this.difficultAttempted,
      difficultSolved: difficultSolved ?? this.difficultSolved,
      expertAttempted: expertAttempted ?? this.expertAttempted,
      expertSolved: expertSolved ?? this.expertSolved,
      totalAttempted: totalAttempted ?? this.totalAttempted,
      totalSolved: totalSolved ?? this.totalSolved,
    );
  }

  @override
  List<Object?> get props => [
        name,
        easyAttempted,
        easySolved,
        mediumAttempted,
        mediumSolved,
        difficultAttempted,
        difficultSolved,
        expertAttempted,
        expertSolved,
      ];
}
