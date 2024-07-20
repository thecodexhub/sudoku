// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/puzzle/puzzle.dart';

class _FakeBlock extends Fake implements Block {}

void main() {
  group('PuzzleEvent', () {
    group('PuzzleInitialized', () {
      test('supports value equality', () {
        expect(
          PuzzleInitialized(),
          equals(PuzzleInitialized()),
        );
      });

      test('props are correct', () {
        expect(PuzzleInitialized().props, equals([]));
      });
    });

    group('SudokuBlockSelected', () {
      final block = _FakeBlock();

      test('supports value equality', () {
        expect(
          SudokuBlockSelected(block),
          equals(SudokuBlockSelected(block)),
        );
      });

      test('props are correct', () {
        expect(
          SudokuBlockSelected(block).props,
          equals(<Object>[block]),
        );
      });
    });

    group('SudokuInputEntered', () {
      test('supports value equality', () {
        expect(
          SudokuInputEntered(4),
          equals(SudokuInputEntered(4)),
        );
      });

      test('props are correct', () {
        expect(
          SudokuInputEntered(4).props,
          equals(<Object>[4]),
        );
      });
    });

    group('SudokuInputErased', () {
      test('supports value equality', () {
        expect(
          SudokuInputErased(),
          equals(SudokuInputErased()),
        );
      });

      test('props are correct', () {
        expect(SudokuInputErased().props, equals([]));
      });
    });
  });
}