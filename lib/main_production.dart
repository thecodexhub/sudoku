import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku/api/api.dart';
import 'package:sudoku/app/app.dart';
import 'package:sudoku/bootstrap.dart';
import 'package:sudoku/cache/cache.dart';
import 'package:sudoku/env/env.dart';
import 'package:sudoku/repository/repository.dart';
import 'package:sudoku/storage/storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  unawaited(
    bootstrap(() async {
      final apiClient = SudokuDioClient(baseUrl: Env.apiBaseUrl);
      final cacheClient = CacheClient();

      final storageClient = LocalStorageClient(
        plugin: await SharedPreferences.getInstance(),
      );

      final puzzleRepository = PuzzleRepository(
        cacheClient: cacheClient,
        storageClient: storageClient,
      );

      return App(
        apiClient: apiClient,
        puzzleRepository: puzzleRepository,
      );
    }),
  );
}
