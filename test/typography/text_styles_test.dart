import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/typography/typography.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = null;

  group('SudokuTextStyle', () {
    test('headlines are defined', () {
      expect(SudokuTextStyle.headline1, isA<TextStyle>());
      expect(SudokuTextStyle.headline2, isA<TextStyle>());
      expect(SudokuTextStyle.headline3, isA<TextStyle>());
      expect(SudokuTextStyle.headline4, isA<TextStyle>());
      expect(SudokuTextStyle.headline5, isA<TextStyle>());
      expect(SudokuTextStyle.headline6, isA<TextStyle>());
    });

    test('subtitles are defined', () {
      expect(SudokuTextStyle.subtitle1, isA<TextStyle>());
      expect(SudokuTextStyle.subtitle2, isA<TextStyle>());
    });

    test('body text are defined', () {
      expect(SudokuTextStyle.bodyText1, isA<TextStyle>());
      expect(SudokuTextStyle.bodyText2, isA<TextStyle>());
    });

    test('caption and button are defined', () {
      expect(SudokuTextStyle.caption, isA<TextStyle>());
      expect(SudokuTextStyle.button, isA<TextStyle>());
    });
  });
}
