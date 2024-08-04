// ignore_for_file: prefer_const_constructors

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sudoku/cache/cache.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/repository/repository.dart';

import '../helpers/helpers.dart';

void main() {
  group('PlayerRepository', () {
    late FakeFirebaseFirestore firestore;
    late CacheClient cacheClient;
    late PlayerRepository playerRepository;

    late List<String> ids;
    late List<Player> players;

    setUp(() async {
      firestore = FakeFirebaseFirestore();
      cacheClient = MockCacheClient();
      playerRepository = PlayerRepository(
        firestore: firestore,
        cacheClient: cacheClient,
      );

      players = [
        Player(
          name: 'player-1',
          easyAttempted: 1,
          easySolved: 1,
          mediumAttempted: 3,
          mediumSolved: 2,
          difficultAttempted: 1,
          difficultSolved: 1,
          expertAttempted: 7,
          expertSolved: 2,
          totalAttempted: 12,
          totalSolved: 6,
        ),
        Player(
          name: 'player-2',
          easyAttempted: 1,
          easySolved: 1,
          mediumAttempted: 6,
          mediumSolved: 3,
          difficultAttempted: 1,
          difficultSolved: 1,
          expertAttempted: 7,
          expertSolved: 3,
          totalAttempted: 18,
          totalSolved: 8,
        ),
        Player(
          name: 'player-3',
          easyAttempted: 3,
          easySolved: 1,
          mediumAttempted: 3,
          mediumSolved: 2,
          difficultAttempted: 1,
          difficultSolved: 1,
          expertAttempted: 4,
          expertSolved: 2,
          totalAttempted: 11,
          totalSolved: 6,
        ),
      ];

      ids = [
        'userId-1',
        'userId-2',
        'userId-3',
      ];

      for (var i = 0; i < ids.length; i++) {
        await firestore.doc('players/${ids[i]}').set(
              players[i].toJson(),
            );
      }
    });

    test('can be instantiated', () {
      expect(playerRepository, isNotNull);
    });

    group('getPlayer', () {
      test('returns empty player when userId is not present', () {
        expect(
          playerRepository.getPlayer('no-player'),
          emits(Player.empty),
        );
      });

      test('returns player with the provided id', () {
        expect(
          playerRepository.getPlayer('userId-2'),
          emits(players[1]),
        );
      });

      test(
        'writes the player info into cache when player is available',
        () async {
          await playerRepository.getPlayer(ids[2]).first;
          verify(
            () => cacheClient.write(
              key: PlayerRepository.playerCacheKey,
              value: players[2],
            ),
          ).called(1);
        },
      );

      test(
        'writes the player info into cache when player is unavailable',
        () async {
          await playerRepository.getPlayer('no-player').first;
          verify(
            () => cacheClient.write(
              key: PlayerRepository.playerCacheKey,
              value: Player.empty,
            ),
          ).called(1);
        },
      );
    });

    group('currentPlayer', () {
      test('returns player from cache', () {
        when(
          () => cacheClient.read<Player>(key: PlayerRepository.playerCacheKey),
        ).thenReturn(players[0]);
        final player = playerRepository.currentPlayer;
        expect(player, equals(players[0]));
      });

      test('returns empty player when cache is empty', () {
        when(
          () => cacheClient.read<Player>(key: PlayerRepository.playerCacheKey),
        ).thenReturn(null);
        final player = playerRepository.currentPlayer;
        expect(player, equals(Player.empty));
      });
    });

    group('updatePlayer', () {
      test('works', () async {
        await playerRepository.updatePlayer('userId-2', players[2]);
        expect(playerRepository.getPlayer('userId-2'), emits(players[2]));
      });
    });
  });
}
