import 'package:flutter/widgets.dart';
import 'package:sudoku/cache/cache.dart';
import 'package:sudoku/puzzle/puzzle.dart';
import 'package:sudoku/storage/storage.dart';

/// {@template puzzle_repository}
/// A repository that handles `puzzle` related data.
///
/// Used to pass data from home page to puzzle page, and to save and
/// retrieve unfinished puzzle from local memory.
/// {@endtemplate}
class PuzzleRepository {
  /// {@macro puzzle_repository}
  const PuzzleRepository({
    required CacheClient cacheClient,
    required StorageAPI storageClient,
  })  : _cacheClient = cacheClient,
        _storageClient = storageClient;

  final CacheClient _cacheClient;

  final StorageAPI _storageClient;

  /// The key used for storing the puzzle in cache.
  ///
  /// This is only exposed for testing and shouldn't be used by consumers of
  /// this library.
  @visibleForTesting
  static const kPuzzleKey = '__puzzle_key__';

  /// Provides the puzzle stored in cache.
  ///
  /// Returns null, if there is no puzzle.
  Puzzle? fetchPuzzleFromCache() => _cacheClient.read<Puzzle>(key: kPuzzleKey);

  /// Saves a puzzle in cache.
  ///
  /// If there's already a puzzle there, it will be replaced.
  void savePuzzleToCache({required Puzzle puzzle}) =>
      _cacheClient.write<Puzzle>(key: kPuzzleKey, value: puzzle);

  /// Emits the puzzle stored in local storage. If there's not puzzle,
  /// it simply emits null.
  Stream<Puzzle?> getPuzzleFromLocalMemory() => _storageClient.getPuzzle();

  /// Stores the puzzle in local storage. The aim is to save unfinished puzzle.
  Future<void> storePuzzleInLocalMemory({required Puzzle puzzle}) =>
      _storageClient.storePuzzle(puzzle: puzzle);

  /// Clears out the local storage, after an unfinished puzzle is completed.
  Future<void> clearPuzzleInLocalMemory() => _storageClient.clearPuzzleStore();

  /// Closed any resources used during the above operations.
  Future<void> close() => _storageClient.close();
}
