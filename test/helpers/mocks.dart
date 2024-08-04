import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku/api/api.dart';
import 'package:sudoku/cache/cache.dart';
import 'package:sudoku/home/home.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/puzzle/puzzle.dart';
import 'package:sudoku/repository/repository.dart';
import 'package:sudoku/storage/storage.dart';
import 'package:sudoku/timer/timer.dart';

class MockSudoku extends Mock implements Sudoku {}

class MockBlock extends Mock implements Block {}

class MockPosition extends Mock implements Position {}

class MockTicker extends Mock implements Ticker {}

class MockTimerBloc extends MockBloc<TimerEvent, TimerState>
    implements TimerBloc {}

class MockSudokuAPI extends Mock implements SudokuAPI {}

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

class MockHomeState extends Mock implements HomeState {}

class MockDio extends Mock implements Dio {}

class MockCacheClient extends Mock implements CacheClient {}

class MockPuzzle extends Mock implements Puzzle {}

class MockPuzzleRepository extends Mock implements PuzzleRepository {}

class MockPuzzleBloc extends MockBloc<PuzzleEvent, PuzzleState>
    implements PuzzleBloc {}

class MockPuzzleState extends Mock implements PuzzleState {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockHint extends Mock implements Hint {}

class MockTimerState extends Mock implements TimerState {}

class MockStorageAPI extends Mock implements StorageAPI {}

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockFirebaseAuth extends Mock implements firebase_auth.FirebaseAuth {}

class MockFirebaseUser extends Mock implements firebase_auth.User {}

class MockUserCredential extends Mock implements firebase_auth.UserCredential {}

class MockFirebaseCore extends Mock
    with MockPlatformInterfaceMixin
    implements FirebasePlatform {}
