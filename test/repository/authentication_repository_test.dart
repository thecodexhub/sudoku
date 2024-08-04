import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sudoku/cache/cache.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/repository/repository.dart';

import '../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const mockFirebaseUserUid = 'mock-uid';
  const user = User(
    id: mockFirebaseUserUid,
  );

  group('AuthenticationRepository', () {
    late CacheClient cacheClient;
    late firebase_auth.FirebaseAuth firebaseAuth;
    late firebase_auth.UserCredential userCredential;
    late AuthenticationRepository authenticationRepository;

    setUp(() {
      const options = FirebaseOptions(
        apiKey: 'apiKey',
        appId: 'appId',
        messagingSenderId: 'messagingSenderId',
        projectId: 'projectId',
      );
      final platformApp = FirebaseAppPlatform(defaultFirebaseAppName, options);
      final firebaseCore = MockFirebaseCore();

      when(() => firebaseCore.apps).thenReturn([platformApp]);
      when(firebaseCore.app).thenReturn(platformApp);
      when(
        () => firebaseCore.initializeApp(
          name: defaultFirebaseAppName,
          options: options,
        ),
      ).thenAnswer((_) async => platformApp);

      Firebase.delegatePackingProperty = firebaseCore;

      cacheClient = MockCacheClient();
      firebaseAuth = MockFirebaseAuth();
      userCredential = MockUserCredential();

      authenticationRepository = AuthenticationRepository(
        cache: cacheClient,
        firebaseAuth: firebaseAuth,
      );
    });

    test('can be instantiated', () {
      expect(AuthenticationRepository(), isNotNull);
    });

    group('user', () {
      test('emits User.unauthenticated when firebase user is null', () async {
        when(() => firebaseAuth.authStateChanges()).thenAnswer(
          (_) => Stream.value(null),
        );
        await expectLater(
          authenticationRepository.user,
          emitsInOrder(const <User>[User.unauthenticated]),
        );
      });

      test('emits returning user when firebase user is not null', () async {
        final firebaseUser = MockFirebaseUser();
        when(() => firebaseUser.uid).thenReturn(mockFirebaseUserUid);
        when(() => firebaseAuth.authStateChanges()).thenAnswer(
          (_) => Stream.value(firebaseUser),
        );

        await expectLater(
          authenticationRepository.user,
          emitsInOrder(const <User>[User(id: mockFirebaseUserUid)]),
        );
      });
    });

    group('currentUser', () {
      test('returns User.unauthenticated when cached user is null', () {
        when(
          () => cacheClient.read(key: AuthenticationRepository.userCacheKey),
        ).thenReturn(null);
        expect(
          authenticationRepository.currentUser,
          equals(User.unauthenticated),
        );
      });

      test('returns User when cached user is not null', () async {
        when(
          () => cacheClient.read<User>(
            key: AuthenticationRepository.userCacheKey,
          ),
        ).thenReturn(user);
        expect(authenticationRepository.currentUser, equals(user));
      });
    });

    group('signInAnonymously', () {
      test('calls signInAnonymously on FirebaseAuth', () async {
        when(() => firebaseAuth.signInAnonymously()).thenAnswer(
          (_) async => userCredential,
        );

        await authenticationRepository.signInAnonymously();
        verify(() => firebaseAuth.signInAnonymously()).called(1);
      });

      test('throws AuthenticationException on failure', () async {
        when(() => firebaseAuth.signInAnonymously()).thenThrow(
          Exception('oops!'),
        );

        expect(
          () => authenticationRepository.signInAnonymously(),
          throwsA(isA<AuthenticationException>()),
        );
      });
    });

    group('signOut', () {
      setUp(() {
        when(() => firebaseAuth.signOut()).thenAnswer((_) async {});
      });

      test('calls signOut on FirebaseAuth', () async {
        await authenticationRepository.signOut();
        verify(() => firebaseAuth.signOut()).called(1);
      });

      test('updates user with unauthenticated', () async {
        when(() => firebaseAuth.authStateChanges()).thenAnswer(
          (_) => Stream.value(null),
        );
        await authenticationRepository.signOut();

        await expectLater(
          authenticationRepository.user,
          emitsInOrder(
            <User>[User.unauthenticated],
          ),
        );
      });
    });
  });

  group('AuthenticationException', () {
    AuthenticationException createSubject() {
      return AuthenticationException('oops!', StackTrace.fromString('mock-st'));
    }

    test('constructor works correctly', () {
      expect(createSubject, returnsNormally);
    });

    test('toString method is defined and returns error as string', () {
      expect(createSubject().toString(), equals('oops!'));
    });
  });
}
