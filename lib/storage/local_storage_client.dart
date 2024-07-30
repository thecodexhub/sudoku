import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku/puzzle/models/puzzle.dart';
import 'package:sudoku/storage/storage.dart';

/// {@template local_storage_client}
/// An implementation of the [StorageAPI] that uses local storage.
/// {@endtemplate}
class LocalStorageClient extends StorageAPI {
  /// {@macro local_storage_client}
  LocalStorageClient({
    required SharedPreferences plugin,
  }) : _plugin = plugin {
    _initializeStreamController();
  }

  final SharedPreferences _plugin;

  final _puzzleStreamController = BehaviorSubject<Puzzle?>.seeded(null);

  void _initializeStreamController() {
    final source = _getValue(kPuzzleStorageKey);
    if (source != null) {
      final jsonMap = json.decode(source) as Map<String, dynamic>;
      final puzzle = Puzzle.fromJson(jsonMap);
      _puzzleStreamController.add(puzzle);
    } else {
      _puzzleStreamController.add(null);
    }
  }

  /// The key used for storing the puzzle locally.
  ///
  /// This is only exposed for testing and shouldn't be used by consumers.
  @visibleForTesting
  static const kPuzzleStorageKey = '__puzzle_storage_key__';

  String? _getValue(String key) => _plugin.getString(key);

  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  @override
  Stream<Puzzle?> getPuzzle() => _puzzleStreamController.asBroadcastStream();

  @override
  Future<void> storePuzzle({required Puzzle puzzle}) async {
    _puzzleStreamController.add(puzzle);
    return _setValue(kPuzzleStorageKey, json.encode(puzzle));
  }

  @override
  Future<void> clearPuzzleStore() async {
    _puzzleStreamController.add(null);
    await _plugin.remove(kPuzzleStorageKey);
    return;
  }

  @override
  Future<void> close() {
    return _puzzleStreamController.close();
  }
}
