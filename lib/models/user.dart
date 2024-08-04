import 'package:equatable/equatable.dart';

/// {@template user}
/// User model.
///
/// [User.unauthenticated] represents an unauthenticated user.
/// {@endtemplate}
class User extends Equatable {
  /// {@macro user}
  const User({
    required this.id,
  });

  /// The current user's id.
  final String id;

  /// Represents an unauthenticated user.
  static const unauthenticated = User(id: '');

  /// Convenience getter to determine whether the current
  /// user is unauthenticated.
  bool get isUnauthenticated => this == User.unauthenticated;

  /// Convenience getter to determine whether the current
  /// user is authenticated.
  bool get isAuthenticated => this != User.unauthenticated;

  @override
  List<Object?> get props => [id];
}
