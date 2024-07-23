import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/puzzle/puzzle.dart';
import 'package:sudoku/storage/storage.dart';

import '../helpers/helpers.dart';

void main() {
  group('LocalStorageClient', () {
    late SharedPreferences plugin;

    const puzzle = Puzzle(
      sudoku: sudoku3x3,
      difficulty: Difficulty.medium,
      totalSecondsElapsed: 12,
      remainingMistakes: 2,
      remainingHints: 1,
    );

    setUp(() {
      plugin = MockSharedPreferences();
      when(() => plugin.getString(any())).thenReturn(json.encode(puzzle));
      when(() => plugin.setString(any(), any())).thenAnswer((_) async => true);
      when(() => plugin.remove(any())).thenAnswer((_) async => true);
    });

    LocalStorageClient createSubject() {
      return LocalStorageClient(plugin: plugin);
    }

    test('constructor works correctly', () {
      expect(createSubject, returnsNormally);
    });

    group('getPuzzle', () {
      test('returns null if there is no saved puzzle', () {
        when(() => plugin.getString(any())).thenReturn(null);
        final client = createSubject();

        expectLater(client.getPuzzle(), completion(null));
        verify(
          () => plugin.getString(LocalStorageClient.kPuzzleStorageKey),
        ).called(1);
      });

      test('returns puzzle if there is a saved puzzle', () {
        final client = createSubject();
        expectLater(client.getPuzzle(), completion(puzzle));
        verify(
          () => plugin.getString(LocalStorageClient.kPuzzleStorageKey),
        ).called(1);
      });
    });

    group('storePuzzle', () {
      test('stores a puzzle in a json encoded format', () {
        final client = createSubject();
        expectLater(client.storePuzzle(puzzle: puzzle), completes);
        verify(
          () => plugin.setString(
            LocalStorageClient.kPuzzleStorageKey,
            json.encode(puzzle),
          ),
        ).called(1);
      });
    });

    group('clearPuzzleStore', () {
      test('removes the data from the key', () {
        final client = createSubject();
        expectLater(client.clearPuzzleStore(), completes);
        verify(
          () => plugin.remove(LocalStorageClient.kPuzzleStorageKey),
        ).called(1);
      });
    });
  });
}
