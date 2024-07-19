import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sudoku/cache/cache.dart';
import 'package:sudoku/puzzle/puzzle.dart';

import '../../helpers/helpers.dart';

void main() {
  group('PuzzleRepository', () {
    late Puzzle puzzle;
    late CacheClient cacheClient;
    late PuzzleRepository puzzleRepository;

    setUp(() {
      puzzle = MockPuzzle();
      cacheClient = MockCacheClient();
      puzzleRepository = PuzzleRepository(cacheClient: cacheClient);
      when(() => cacheClient.read(key: any(named: 'key'))).thenReturn(puzzle);
    });

    group('getPuzzle', () {
      test('calls the read method from [CacheClient]', () {
        puzzleRepository.getPuzzle();
        verify(
          () => cacheClient.read<Puzzle>(key: PuzzleRepository.kPuzzleKey),
        ).called(1);
      });
    });

    group('storePuzzle', () {
      test('calls the write method from [CacheClient]', () {
        puzzleRepository.storePuzzle(puzzle: puzzle);
        verify(
          () => cacheClient.write<Puzzle>(
            key: PuzzleRepository.kPuzzleKey,
            value: puzzle,
          ),
        ).called(1);
      });
    });
  });
}
