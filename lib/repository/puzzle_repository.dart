import 'package:flutter/widgets.dart';
import 'package:sudoku/cache/cache.dart';
import 'package:sudoku/puzzle/puzzle.dart';

/// {@template puzzle_repository}
/// A repository that handles `puzzle` related data.
///
/// Used to pass data from home page to puzzle page.
/// {@endtemplate}
class PuzzleRepository {
  /// {@macro puzzle_repository}
  const PuzzleRepository({
    required CacheClient cacheClient,
  }) : _cacheClient = cacheClient;

  final CacheClient _cacheClient;

  /// The key used for storing the puzzle in-memory.
  ///
  /// This is only exposed for testing and shouldn't be used by consumers of
  /// this library.
  @visibleForTesting
  static const kPuzzleKey = '__puzzle_key__';

  /// Provides the puzzle stored in-memory.
  ///
  /// Returns null, if there is no puzzle.
  Puzzle? getPuzzle() => _cacheClient.read<Puzzle>(key: kPuzzleKey);

  /// Saves a puzzle in-memory.
  ///
  /// If there's already a puzzle there, it will be replaced.
  void storePuzzle({required Puzzle puzzle}) =>
      _cacheClient.write<Puzzle>(key: kPuzzleKey, value: puzzle);
}
