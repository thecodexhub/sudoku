import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sudoku/api/api.dart';
import 'package:sudoku/app/app.dart';
import 'package:sudoku/home/home.dart';
import 'package:sudoku/puzzle/puzzle.dart';
import 'package:sudoku/repository/repository.dart';

import '../../helpers/helpers.dart';

void main() {
  group('App', () {
    late Puzzle puzzle;
    late SudokuAPI apiClient;
    late PuzzleRepository puzzleRepository;

    setUp(() {
      puzzle = MockPuzzle();
      apiClient = MockSudokuAPI();
      puzzleRepository = MockPuzzleRepository();

      when(() => puzzleRepository.getPuzzleFromLocalMemory()).thenAnswer(
        (_) => Stream.value(puzzle),
      );
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
