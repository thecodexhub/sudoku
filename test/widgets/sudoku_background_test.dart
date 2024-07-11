import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/colors/colors.dart';
import 'package:sudoku/widgets/widgets.dart';

class MockCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {}

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

void main() {
  group('GradientBackgroundPainter', () {
    test('extends [CustomPainter] and [shouldRepaint] is set to true', () {
      final widget = GradientBackgroundPainter(
        brightness: Brightness.light,
      );
      final mockPainter = MockCustomPainter();
      expect(widget, isA<CustomPainter>());
      expect(widget.shouldRepaint(mockPainter), true);
    });

    test('uses colors for gradient based on [Brightness]', () {
      final lightWidget = GradientBackgroundPainter(
        brightness: Brightness.light,
      );

      final darkWidget = GradientBackgroundPainter(
        brightness: Brightness.dark,
      );

      expect(
        lightWidget.colors(),
        equals(
          [
            SudokuColors.lightPink,
            SudokuColors.lightPurple,
          ],
        ),
      );

      expect(
        darkWidget.colors(),
        equals(
          [
            SudokuColors.darkPink,
            SudokuColors.darkPurple,
          ],
        ),
      );
    });
  });
}
