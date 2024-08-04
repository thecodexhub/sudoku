import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sudoku/api/api.dart';
import 'package:sudoku/app/app.dart';
import 'package:sudoku/home/home.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/puzzle/puzzle.dart';
import 'package:sudoku/repository/repository.dart';

import '../../helpers/helpers.dart';

void main() {
  group('App', () {
    late Puzzle puzzle;
    late User user;
    late SudokuAPI apiClient;

    late PuzzleRepository puzzleRepository;
    late AuthenticationRepository authenticationRepository;
    late PlayerRepository playerRepository;

    setUp(() {
      puzzle = MockPuzzle();
      user = MockUser();
      apiClient = MockSudokuAPI();

      puzzleRepository = MockPuzzleRepository();
      authenticationRepository = MockAuthenticationRepository();
      playerRepository = MockPlayerRepository();

      when(() => puzzleRepository.getPuzzleFromLocalMemory()).thenAnswer(
        (_) => Stream.value(puzzle),
      );

      when(() => user.id).thenReturn('mock-user');
      when(() => authenticationRepository.currentUser).thenReturn(user);
      when(() => playerRepository.getPlayer(any())).thenAnswer(
        (_) => Stream.value(MockPlayer()),
      );
    });

    testWidgets('renders HomePage', (tester) async {
      await tester.pumpWidget(
        App(
          apiClient: apiClient,
          puzzleRepository: puzzleRepository,
          authenticationRepository: authenticationRepository,
          playerRepository: playerRepository,
        ),
      );
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
