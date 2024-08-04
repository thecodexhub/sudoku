import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:sudoku/cache/cache.dart';
import 'package:sudoku/models/models.dart';

const _collection = 'players';

/// {@template player_repository}
/// Repository which manages player.
/// {@endtemplate}
class PlayerRepository {
  /// {@macro player_repository}
  PlayerRepository({
    required FirebaseFirestore firestore,
    required CacheClient cacheClient,
  })  : _playersCollection = firestore.collection(_collection),
        _cache = cacheClient;

  final CollectionReference<Map<String, dynamic>> _playersCollection;
  final CacheClient _cache;

  /// Player cache key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const playerCacheKey = '__player_cache_key__';

  /// Returns a [Stream] of the [Player] with the `userId`.
  Stream<Player> getPlayer(String userId) {
    return _playersCollection.doc(userId).snapshots().map((snapshot) {
      if (!snapshot.exists) {
        _cache.write<Player>(key: playerCacheKey, value: Player.empty);
        return Player.empty;
      }

      final player = Player.fromJson(snapshot.data()!);
      _cache.write<Player>(key: playerCacheKey, value: player);
      return Player.fromJson(snapshot.data()!);
    });
  }

  /// Returns the current cached player.
  /// Defaults to [Player.empty] if there is no cached player.
  Player get currentPlayer {
    return _cache.read<Player>(key: playerCacheKey) ?? Player.empty;
  }

  /// Updates information of the [player] with the `userId`.
  Future<void> updatePlayer(String userId, Player player) {
    return _playersCollection.doc(userId).set(player.toJson());
  }
}
