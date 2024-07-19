/// Defines the status of the puzzle.
enum PuzzleStatus {
  /// The puzzle is in progress.
  incomplete,

  /// The puzzle is successfully solved.
  complete,

  /// The puzzle is over.
  ///
  /// One reason could be the user has exhausted all
  /// the remaining mistakes.
  failed,
}
