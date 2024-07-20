import 'package:sudoku/api/api.dart';
import 'package:sudoku/app/app.dart';
import 'package:sudoku/bootstrap.dart';
import 'package:sudoku/cache/cache.dart';
import 'package:sudoku/env/env.dart';
import 'package:sudoku/puzzle/puzzle.dart';

void main() {
  bootstrap(() {
    final apiClient = SudokuDioClient(baseUrl: Env.apiBaseUrl);

    final cacheClient = CacheClient();
    final puzzleRepository = PuzzleRepository(cacheClient: cacheClient);

    return App(
      apiClient: apiClient,
      puzzleRepository: puzzleRepository,
    );
  });
}
