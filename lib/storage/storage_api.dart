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

  /// Provides a [Stream] of the stored puzzle.
  ///
  /// Emits null, if there is no puzzle stored.
  Stream<Puzzle?> getPuzzle();

  /// Clears the stored puzzle.
  Future<void> clearPuzzleStore();

  /// Closes the client and frees up any resources.
  Future<void> close();
}
