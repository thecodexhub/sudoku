import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/colors/colors.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/utilities/utilities.dart';

void main() {
  group('DifficultyExtension', () {
    group('color', () {
      test('returns correct SudokuColor', () {
        expect(Difficulty.easy.color, equals(SudokuColors.green));
        expect(Difficulty.medium.color, equals(SudokuColors.amber));
        expect(Difficulty.difficult.color, equals(SudokuColors.orange));
        expect(Difficulty.expert.color, equals(SudokuColors.teal));
      });
    });

    group('article', () {
      test('returns correct article', () {
        expect(Difficulty.easy.article, equals('an'));
        expect(Difficulty.medium.article, equals('a'));
        expect(Difficulty.difficult.article, equals('a'));
        expect(Difficulty.expert.article, equals('an'));
      });
    });
  });
}
