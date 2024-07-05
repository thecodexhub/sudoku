import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/app/app.dart';
import 'package:sudoku/sudoku/sudoku.dart';

void main() {
  group('App', () {
    testWidgets('renders SudokuPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(SudokuPage), findsOneWidget);
    });
  });
}
