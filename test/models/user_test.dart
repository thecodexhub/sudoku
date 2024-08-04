// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/models/models.dart';

void main() {
  group('User', () {
    const id = 'mock-id';

    test('uses value equality', () {
      expect(
        User(id: id),
        equals(User(id: id)),
      );
    });

    test('props are correct', () {
      final user = User(id: id);
      expect(user.props, equals([id]));
    });

    test('isUnauthenticated returns true for unauthenticated user', () {
      expect(User.unauthenticated.isUnauthenticated, isTrue);
    });

    test('isUnauthenticated returns false for authenticated user', () {
      final user = User(id: id);
      expect(user.isUnauthenticated, isFalse);
    });

    test('isAuthenticated returns false for unauthenticated user', () {
      expect(User.unauthenticated.isAuthenticated, isFalse);
    });

    test('isAuthenticated returns true for authenticated user', () {
      final user = User(id: id);
      expect(user.isAuthenticated, isTrue);
    });
  });
}
