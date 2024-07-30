import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sudoku/cache/cache.dart';
import 'package:sudoku/puzzle/puzzle.dart';
import 'package:sudoku/repository/repository.dart';
import 'package:sudoku/storage/storage.dart';

import '../helpers/helpers.dart';

class _FakePuzzle extends Fake implements Puzzle {}

void main() {
  group('PuzzleRepository', () {
    late Puzzle puzzle;
    late CacheClient cacheClient;
    late StorageAPI storageClient;
    late PuzzleRepository puzzleRepository;

    setUp(() {
      puzzle = MockPuzzle();
      cacheClient = MockCacheClient();
      storageClient = MockStorageAPI();

      puzzleRepository = PuzzleRepository(
        cacheClient: cacheClient,
        storageClient: storageClient,
      );

      when(() => cacheClient.read(key: any(named: 'key'))).thenReturn(puzzle);
      when(() => storageClient.getPuzzle()).thenAnswer(
        (_) => Stream.value(puzzle),
      );
      when(
        () => storageClient.storePuzzle(puzzle: any(named: 'puzzle')),
      ).thenAnswer((_) async {});
      when(() => storageClient.clearPuzzleStore()).thenAnswer((_) async {});
      when(() => storageClient.close()).thenAnswer((_) async {});
    });

    setUpAll(() {
      registerFallbackValue(_FakePuzzle());
    });

    group('fetchPuzzleFromCache', () {
      test('calls the read method from [CacheClient]', () {
        puzzleRepository.fetchPuzzleFromCache();
        verify(
          () => cacheClient.read<Puzzle>(key: PuzzleRepository.kPuzzleKey),
        ).called(1);
      });
    });

    group('savePuzzleToCache', () {
      test('calls the write method from [CacheClient]', () {
        puzzleRepository.savePuzzleToCache(puzzle: puzzle);
        verify(
          () => cacheClient.write<Puzzle>(
            key: PuzzleRepository.kPuzzleKey,
            value: puzzle,
          ),
        ).called(1);
      });
    });

    group('getPuzzleFromLocalMemory', () {
      test('calls the getPuzzle method from [StorageAPI]', () {
        puzzleRepository.getPuzzleFromLocalMemory();
        verify(() => storageClient.getPuzzle()).called(1);
      });
    });

    group('storePuzzleInLocalMemory', () {
      test('calls the storePuzzle method from [StorageAPI]', () {
        puzzleRepository.storePuzzleInLocalMemory(puzzle: puzzle);
        verify(() => storageClient.storePuzzle(puzzle: puzzle)).called(1);
      });
    });

    group('clearPuzzleInLocalMemory', () {
      test('calls clearPuzzleStore method from [StorageAPI]', () {
        puzzleRepository.clearPuzzleInLocalMemory();
        verify(() => storageClient.clearPuzzleStore()).called(1);
      });
    });

    group('close', () {
      test('calls the close method from [StorageAPI]', () {
        puzzleRepository.close();
        verify(() => storageClient.close()).called(1);
      });
    });
  });
}
