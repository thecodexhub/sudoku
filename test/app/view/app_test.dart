import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/api/api.dart';
import 'package:sudoku/app/app.dart';
import 'package:sudoku/home/home.dart';
import 'package:sudoku/puzzle/puzzle.dart';

import '../../helpers/helpers.dart';

void main() {
  group('App', () {
    late SudokuAPI apiClient;
    late PuzzleRepository puzzleRepository;

    setUp(() {
      apiClient = MockSudokuAPI();
      puzzleRepository = MockPuzzleRepository();
    });

    testWidgets('renders HomePage', (tester) async {
      await tester.pumpWidget(
        App(
          apiClient: apiClient,
          puzzleRepository: puzzleRepository,
        ),
      );
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
