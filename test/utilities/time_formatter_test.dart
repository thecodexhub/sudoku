import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/utilities/utilities.dart';

void main() {
  group('TimeFormatter', () {
    test('returns correct formatted string', () {
      expect(15.format, equals('00:00:15'));
      expect(137.format, equals('00:02:17'));
      expect(3662.format, equals('01:01:02'));
    });
  });
}
