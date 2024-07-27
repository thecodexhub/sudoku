// ignore_for_file: avoid_redundant_argument_values,
// inference_failure_on_function_invocation

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sudoku/api/api.dart';
import 'package:sudoku/models/models.dart';

import '../../helpers/helpers.dart';

void main() {
  group('SudokuDioClient', () {
    const defaultBaseUrl = 'http://localhost:3400';
    SudokuDioClient createSubject({
      String? baseUrl,
      Dio? dioClient,
    }) {
      return SudokuDioClient(
        baseUrl: baseUrl ?? defaultBaseUrl,
        dioClient: dioClient,
      );
    }

    test('correctly declares dio client', () {
      expect(
        createSubject().dioClient,
        isA<Dio>().having((d) => d.options.baseUrl, 'baseUrl', defaultBaseUrl),
      );
    });

    group('createSudoku', () {
      late Dio dioClient;

      setUp(() {
        dioClient = MockDio();
        when(
          () => dioClient.post<Map<String, dynamic>>(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) async => Future.value(
            Response(
              requestOptions: RequestOptions(),
              data: {
                'result': {
                  'puzzle': [
                    [1],
                  ],
                  'solution': [
                    [1],
                  ],
                },
              },
              statusCode: 200,
            ),
          ),
        );
      });

      test('request body is correct', () async {
        final subject = createSubject(dioClient: dioClient);

        final response = await subject.createSudoku(
          difficulty: Difficulty.easy,
        );

        expect(response, isA<Sudoku>());
        verify(
          () => dioClient.post<Map<String, dynamic>>(
            SudokuDioClient.createSudokuPath,
            data: {
              'data': {'difficulty': 'easy'},
            },
            options: any(named: 'options'),
          ),
        ).called(1);
      });

      test(
        'throws a SudokuAPIClientException when response data is null',
        () async {
          final subject = createSubject(dioClient: dioClient);

          when(
            () => dioClient.post<Map<String, dynamic>>(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            ),
          ).thenAnswer(
            (_) async => Future.value(
              Response(
                requestOptions: RequestOptions(),
                data: null,
                statusCode: 200,
              ),
            ),
          );

          expect(
            () async => subject.createSudoku(difficulty: Difficulty.easy),
            throwsA(isA<SudokuAPIClientException>()),
          );
        },
      );

      test(
        'throws a SudokuAPIClientException when dio exception is thrown',
        () async {
          final subject = createSubject(dioClient: dioClient);

          when(
            () => dioClient.post<Map<String, dynamic>>(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            ),
          ).thenThrow(
            DioException(requestOptions: RequestOptions()),
          );

          expect(
            () async => subject.createSudoku(difficulty: Difficulty.easy),
            throwsA(isA<SudokuAPIClientException>()),
          );
        },
      );

      test(
        'throws a SudokuInvalidRawDataException when response data is invalid',
        () async {
          final subject = createSubject(dioClient: dioClient);

          when(
            () => dioClient.post<Map<String, dynamic>>(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            ),
          ).thenAnswer(
            (_) async => Future.value(
              Response(
                requestOptions: RequestOptions(),
                data: {
                  'result': {
                    'puzzle': [
                      [1],
                    ],
                    'solution': [
                      [1],
                      [2],
                    ],
                  },
                },
                statusCode: 200,
              ),
            ),
          );

          expect(
            () async => subject.createSudoku(difficulty: Difficulty.easy),
            throwsA(isA<SudokuInvalidRawDataException>()),
          );
        },
      );
    });

    group('generateSudoku', () {
      late Dio dioClient;

      setUp(() {
        dioClient = MockDio();
        when(
          () => dioClient.post<Map<String, dynamic>>(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) async => Future.value(
            Response(
              requestOptions: RequestOptions(),
              data: {
                'result': {
                  'cell': [0, 1],
                  'entry': 5,
                  'observation': 'some observation',
                  'explanation': 'some explanation',
                  'solution': 'some solution',
                },
              },
              statusCode: 200,
            ),
          ),
        );
      });

      test('request body is correct', () async {
        final subject = createSubject(dioClient: dioClient);
        final response = await subject.generateHint(sudoku: sudoku3x3);

        expect(response, isA<Hint>());
        verify(
          () => dioClient.post<Map<String, dynamic>>(
            SudokuDioClient.generateHintPath,
            data: {
              'data': {
                'puzzle': sudoku3x3.toRawData().$1,
                'solution': sudoku3x3.toRawData().$2,
              },
            },
            options: any(named: 'options'),
          ),
        ).called(1);
      });

      test(
        'throws a SudokuAPIClientException when response data is null',
        () async {
          final subject = createSubject(dioClient: dioClient);

          when(
            () => dioClient.post<Map<String, dynamic>>(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            ),
          ).thenAnswer(
            (_) async => Future.value(
              Response(
                requestOptions: RequestOptions(),
                data: null,
                statusCode: 200,
              ),
            ),
          );

          expect(
            () async => subject.generateHint(sudoku: sudoku3x3),
            throwsA(isA<SudokuAPIClientException>()),
          );
        },
      );

      test(
        'throws a SudokuAPIClientException when dio exception is thrown',
        () async {
          final subject = createSubject(dioClient: dioClient);

          when(
            () => dioClient.post<Map<String, dynamic>>(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            ),
          ).thenThrow(
            DioException(requestOptions: RequestOptions()),
          );

          expect(
            () async => subject.generateHint(sudoku: sudoku3x3),
            throwsA(isA<SudokuAPIClientException>()),
          );
        },
      );
    });
  });
}
