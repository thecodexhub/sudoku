import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku/api/api.dart';
import 'package:sudoku/app/app.dart';
import 'package:sudoku/bootstrap.dart';
import 'package:sudoku/cache/cache.dart';
import 'package:sudoku/env/env.dart';
import 'package:sudoku/firebase_options_staging.dart';
import 'package:sudoku/repository/repository.dart';
import 'package:sudoku/storage/storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  unawaited(
    bootstrap((firebaseAuth, firestore) async {
      final apiClient = SudokuDioClient(baseUrl: Env.apiBaseUrl);
      final cacheClient = CacheClient();

      final storageClient = LocalStorageClient(
        plugin: await SharedPreferences.getInstance(),
      );

      final authenticationRepository = AuthenticationRepository(
        cache: cacheClient,
        firebaseAuth: firebaseAuth,
      );

      // Check if the user is already authenticated.
      var user = await authenticationRepository.user.first;

      // If the user is not already authenticated, authenticate anonymously.
      if (user.isUnauthenticated) {
        await authenticationRepository.signInAnonymously();
        user = await authenticationRepository.user.first;
      }

      final puzzleRepository = PuzzleRepository(
        cacheClient: cacheClient,
        storageClient: storageClient,
      );

      final playerRepository = PlayerRepository(
        firestore: firestore,
        cacheClient: cacheClient,
      );

      return App(
        apiClient: apiClient,
        puzzleRepository: puzzleRepository,
        authenticationRepository: authenticationRepository,
        playerRepository: playerRepository,
      );
    }),
  );
}
