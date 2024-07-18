import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/api/api.dart';

class TestSudokuAPI extends SudokuAPI {
  const TestSudokuAPI() : super();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}

void main() {
  group('SudokuAPI', () {
    test('can be constructed', () {
      expect(TestSudokuAPI.new, returnsNormally);
    });
  });
}
