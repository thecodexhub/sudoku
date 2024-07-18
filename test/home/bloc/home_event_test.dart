// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/home/home.dart';
import 'package:sudoku/models/models.dart';

void main() {
  group('HomeEvent', () {
    group('SudokuCreationRequested', () {
      test('supports value equality', () {
        expect(
          SudokuCreationRequested(Difficulty.medium),
          equals(SudokuCreationRequested(Difficulty.medium)),
        );
      });

      test('props are correct', () {
        expect(
          SudokuCreationRequested(Difficulty.medium).props,
          equals(<Object?>[Difficulty.medium]),
        );
      });
    });
  });
}
