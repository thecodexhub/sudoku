import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/layout/layout.dart';

extension ResponsiveWidgetTester on WidgetTester {
  void setDisplaySize(Size size) {
    view
      ..physicalSize = size
      ..devicePixelRatio = 1.0;
    addTearDown(() {
      view
        ..resetPhysicalSize()
        ..resetDevicePixelRatio();
    });
  }

  void setLargeDisplaySize() {
    setDisplaySize(const Size(SudokuBreakpoint.large, 1000));
  }

  void setMediumDisplaySize() {
    setDisplaySize(const Size(SudokuBreakpoint.medium, 1000));
  }

  void setSmallDisplaySize() {
    setDisplaySize(const Size(SudokuBreakpoint.small, 1000));
  }
}
