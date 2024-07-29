import 'package:flutter/material.dart';
import 'package:sudoku/colors/colors.dart';
import 'package:sudoku/models/models.dart';

extension DifficultyExtension on Difficulty {
  Color get color {
    switch (this) {
      case Difficulty.easy:
        return SudokuColors.green;
      case Difficulty.medium:
        return SudokuColors.amber;
      case Difficulty.difficult:
        return SudokuColors.orange;
      case Difficulty.expert:
        return SudokuColors.teal;
    }
  }

  String get article {
    switch (this) {
      case Difficulty.easy:
      case Difficulty.expert:
        return 'an';
      case Difficulty.medium:
      case Difficulty.difficult:
        return 'a';
    }
  }
}
