import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/sudoku/sudoku.dart';

class MockSudoku extends Mock implements Sudoku {}

class MockSudokuBloc extends MockBloc<SudokuEvent, SudokuState>
    implements SudokuBloc {}

class MockSudokuState extends Mock implements SudokuState {}

class MockBlock extends Mock implements Block {}
