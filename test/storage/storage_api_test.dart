import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/storage/storage.dart';

class TestStorageAPI extends StorageAPI {
  const TestStorageAPI() : super();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}

void main() {
  group('StorageAPI', () {
    test('can be constructed', () {
      expect(TestStorageAPI.new, returnsNormally);
    });
  });
}
