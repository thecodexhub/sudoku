import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sudoku/api/api.dart';
import 'package:sudoku/api/dtos/dtos.dart';
import 'package:sudoku/models/difficulty.dart';
import 'package:sudoku/models/sudoku.dart';

/// {@template sudoku_dio_client}
/// An implemetation of the [SudokuAPI] using [Dio] as the http client.
/// {@endtemplate}
class SudokuDioClient extends SudokuAPI {
  /// {@macro sudoku_dio_client}
  SudokuDioClient({
    required String baseUrl,
    Dio? dioClient,
  }) : dioClient = dioClient != null
            ? (dioClient..options = BaseOptions(baseUrl: baseUrl))
            : Dio(BaseOptions(baseUrl: baseUrl));

  @visibleForTesting
  final Dio dioClient;

  /// HTTP request path for creating sudoku
  static const createSudokuPath = '/createSudokuFlow';

  @override
  Future<Sudoku> createSudoku({required Difficulty difficulty}) async {
    try {
      final response = await dioClient.post<Map<String, dynamic>>(
        createSudokuPath,
        data: CreateSudokuRequestDto(
          data: CreateSudokuRequest(difficulty: difficulty.name),
        ).toJson(),
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );

      if (response.data == null) {
        throw const SudokuAPIClientException();
      }

      final responseDto = CreateSudokuResponseDto.fromJson(response.data!);

      final puzzle = responseDto.result.puzzle;
      final solution = responseDto.result.solution;

      return Sudoku.fromRawData(puzzle, solution);
    } on SudokuInvalidRawDataException catch (_) {
      rethrow;
    } on DioException catch (error) {
      throw SudokuAPIClientException(error: error);
    } catch (e) {
      throw const SudokuAPIClientException();
    }
  }
}
