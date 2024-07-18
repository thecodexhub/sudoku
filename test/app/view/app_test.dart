import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/api/api.dart';
import 'package:sudoku/app/app.dart';
import 'package:sudoku/home/home.dart';

import '../../helpers/helpers.dart';

void main() {
  group('App', () {
    late SudokuAPI apiClient;

    setUp(() {
      apiClient = MockSudokuAPI();
    });

    testWidgets('renders HomePage', (tester) async {
      await tester.pumpWidget(App(apiClient: apiClient));
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
