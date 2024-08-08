import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/widgets/widgets.dart';

import '../helpers/helpers.dart';

class MockCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {}

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

void main() {
  group('GradientBackgroundPainter', () {
    late BuildContext context;

    setUp(() {
      context = MockBuildContext();
    });

    test('extends [CustomPainter] and [shouldRepaint] is set to true', () {
      final widget = GradientBackgroundPainter(context: context);
      final mockPainter = MockCustomPainter();
      expect(widget, isA<CustomPainter>());
      expect(widget.shouldRepaint(mockPainter), true);
    });
  });
}
