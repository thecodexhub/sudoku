import 'package:sudoku/puzzle/puzzle.dart';

/// {@template storage_api}
/// The interface for an API that provides access to locally/remotely stored puzzle.
/// {@endtemplate}
abstract class StorageAPI {
  /// {@macro storage_api}
  const StorageAPI();

  /// Saves a [puzzle].
  ///
  /// If a [puzzle] exists, it will be replaced.
  Future<void> storePuzzle({required Puzzle puzzle});

  /// Provides the stored puzzle.
  /// 
  /// Returns null, if there is no puzzle stored.
  Future<Puzzle?> getPuzzle();

  /// Clears the stored puzzle.
  Future<void> clearPuzzleStore();
}
