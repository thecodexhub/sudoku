import 'package:sudoku/models/models.dart';

/// {@template sudoku_api}
/// The interface for an API providing access to sudoku.
/// {@endtemplate}
abstract class SudokuAPI {
  /// {@macro sudoku_api}
  const SudokuAPI();

  /// Creates a [Sudoku] game depending upon the `difficulty`.
  ///
  /// Sends a HTTP request to the sudoku backend, which utilises
  /// Firebase Genkit to generate a sudoku.
  ///
  /// Throws [SudokuAPIClientException] when there's an error during
  /// the http operation.
  ///
  /// Throws a [SudokuInvalidRawDataException] when there's an error
  /// during converting the raw data into [Sudoku] object.
  Future<Sudoku> createSudoku({required Difficulty difficulty});

  /// Creates a [Hint] for the puzzle.
  ///
  /// Sends a HTTP request to the sudoku backend, which utilises
  /// Firebase genkit to generate a hint based on current state of the puzzle.
  Future<Hint> generateHint({required Sudoku sudoku});
}

/// {@template sudoku_api_client_exception}
/// Throws an exception when there is an error during http operation.
/// {@endtemplate}
class SudokuAPIClientException implements Exception {
  /// {@macro sudoku_api_client_exception}
  const SudokuAPIClientException({this.error});

  /// The associated error.
  final dynamic error;
}
