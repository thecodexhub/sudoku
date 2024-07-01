// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/sudoku/sudoku.dart';

void main() {
  const mockBlock = Block(
    position: Position(x: 0, y: 2),
    correctValue: 3,
    currentValue: -1,
  );

  group('SudokuEvent', () {
    group('SudokuBlockSelected', () {
      test('supports value equality', () {
        expect(
          SudokuBlockSelected(mockBlock),
          equals(SudokuBlockSelected(mockBlock)),
        );
      });

      test('props are correct', () {
        expect(
          SudokuBlockSelected(mockBlock).props,
          equals(<Object?>[mockBlock]),
        );
      });
    });

    group('SudokuInputTapped', () {
      test('supports value equality', () {
        expect(
          SudokuInputTapped(2),
          equals(SudokuInputTapped(2)),
        );
      });

      test('props are correct', () {
        expect(
          SudokuInputTapped(5).props,
          equals(<Object?>[5]),
        );
      });
    });
  });
}
