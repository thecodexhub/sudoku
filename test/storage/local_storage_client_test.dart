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

    group('constructor', () {
      test('works correctly', () {
        expect(createSubject, returnsNormally);
      });

      group('initializes the puzzle stream', () {
        test('with existing puzzle if present', () {
          final subject = createSubject();
          expect(subject.getPuzzle(), emits(puzzle));
          verify(
            () => plugin.getString(LocalStorageClient.kPuzzleStorageKey),
          ).called(1);
        });

        test('with null if puzzle is not present', () {
          when(() => plugin.getString(any())).thenReturn(null);

          final subject = createSubject();
          expect(subject.getPuzzle(), emits(null));
          verify(
            () => plugin.getString(LocalStorageClient.kPuzzleStorageKey),
          ).called(1);
        });
      });
    });

    group('getPuzzle', () {
      test('returns stream of puzzle', () {
        final client = createSubject();

        expect(client.getPuzzle(), emits(puzzle));
        verify(
          () => plugin.getString(LocalStorageClient.kPuzzleStorageKey),
        ).called(1);
      });
    });

    group('storePuzzle', () {
      test('stores a puzzle in a json encoded format', () {
        const newPuzzle = Puzzle(
          sudoku: sudoku3x3,
          difficulty: Difficulty.easy,
          totalSecondsElapsed: 100,
          remainingMistakes: 1,
          remainingHints: 0,
        );

        final client = createSubject();

        expect(client.storePuzzle(puzzle: newPuzzle), completes);
        expect(client.getPuzzle(), emits(newPuzzle));

        verify(
          () => plugin.setString(
            LocalStorageClient.kPuzzleStorageKey,
            json.encode(newPuzzle),
          ),
        ).called(1);
      });
    });

    group('clearPuzzleStore', () {
      test('removes the data from the key', () {
        final client = createSubject();
        
        expect(client.clearPuzzleStore(), completes);
        expect(client.getPuzzle(), emits(null));

        verify(
          () => plugin.remove(LocalStorageClient.kPuzzleStorageKey),
        ).called(1);
      });
    });

    group('close', () {
      test('closes the instance', () async {
        final subject = createSubject();
        await subject.close();

        expect(
          () => subject.storePuzzle(puzzle: puzzle),
          throwsStateError,
        );
      });
    });
  });
}
