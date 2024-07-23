import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku/puzzle/models/puzzle.dart';
import 'package:sudoku/storage/storage.dart';

/// {@template local_storage_client}
/// An implementation of the [StorageAPI] that uses local storage.
/// {@endtemplate}
class LocalStorageClient extends StorageAPI {
  /// {@macro local_storage_client}
  const LocalStorageClient({
    required SharedPreferences plugin,
  }) : _plugin = plugin;

  final SharedPreferences _plugin;

  /// The key used for storing the puzzle locally.
  ///
  /// This is only exposed for testing and shouldn't be used by consumers.
  @visibleForTesting
  static const kPuzzleStorageKey = '__puzzle_storage_key__';

  String? _getValue(String key) => _plugin.getString(key);

  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  @override
  Future<Puzzle?> getPuzzle() async {
    final source = _getValue(kPuzzleStorageKey);
    if (source == null) return null;

    final jsonMap = json.decode(source) as Map<String, dynamic>;
    return Puzzle.fromJson(jsonMap);
  }

  @override
  Future<void> storePuzzle({required Puzzle puzzle}) async {
    return _setValue(kPuzzleStorageKey, json.encode(puzzle));
  }

  @override
  Future<void> clearPuzzleStore() async {
    await _plugin.remove(kPuzzleStorageKey);
    return;
  }
}
