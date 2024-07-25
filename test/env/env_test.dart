import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/env/env.dart';

void main() {
  group('Env', () {
    test('sets up environment variables correctly', () {
      expect(Env.apiBaseUrl, isA<String>());
      expect(Env.apiKey, isA<String>());
    });
  });
}
