import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:sudoku/cache/cache.dart';
import 'package:sudoku/models/models.dart';

/// {@template authentication_exception}
/// Exception thrown when an authentication process fails.
/// {@endtemplate}
class AuthenticationException implements Exception {
  /// {@macro authentication_exception}
  const AuthenticationException(this.error, this.stackTrace);

  /// The error that was caught.
  final Object error;

  /// The stack trace associated with the error.
  final StackTrace stackTrace;

  @override
  String toString() {
    return error.toString();
  }
}

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  AuthenticationRepository({
    CacheClient? cache,
    firebase_auth.FirebaseAuth? firebaseAuth,
  })  : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final CacheClient _cache;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  /// User cache key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.unauthenticated] if the user is not authenticated.
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((fbUser) {
      final user = fbUser == null ? User.unauthenticated : fbUser.toUser;
      _cache.write(key: userCacheKey, value: user);
      return user;
    });
  }

  /// Returns the current cached user.
  /// Defaults to [User.unauthenticated] if there is no cached user.
  User get currentUser {
    return _cache.read<User>(key: userCacheKey) ?? User.unauthenticated;
  }

  /// Sign in the user anonymously.
  ///
  /// If the sign in fails, an [AuthenticationException] is thrown.
  Future<void> signInAnonymously() async {
    try {
      await _firebaseAuth.signInAnonymously();
    } on Exception catch (error, stackTrace) {
      throw AuthenticationException(error, stackTrace);
    }
  }

  /// Signs out the current user which will emit
  /// [User.unauthenticated] from the [user] stream.
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

extension on firebase_auth.User {
  /// Maps a [firebase_auth.User] into a [User].
  User get toUser {
    return User(id: uid);
  }
}
