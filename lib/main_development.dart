import 'package:sudoku/api/api.dart';
import 'package:sudoku/app/app.dart';
import 'package:sudoku/bootstrap.dart';
import 'package:sudoku/env/env.dart';

void main() {
  bootstrap(() {
    final apiClient = SudokuDioClient(baseUrl: Env.apiBaseUrl);
    return App(apiClient: apiClient);
  });
}
