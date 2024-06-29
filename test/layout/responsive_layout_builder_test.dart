// ignore_for_file: prefer_const_constructors

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/layout/layout.dart';

import '../helpers/helpers.dart';

void main() {
  group('ResponsiveLayoutBuilder', () {
    late Key smallKey;
    late Key mediumKey;
    late Key largeKey;
    late Key childKey;

    late ResponsiveLayoutBuilder widgetWithoutChild;
    late ResponsiveLayoutBuilder widgetWithChild;

    setUp(() {
      smallKey = Key('__small__');
      mediumKey = Key('__medium__');
      largeKey = Key('__large__');
      childKey = Key('__child__');

      widgetWithoutChild = ResponsiveLayoutBuilder(
        small: (_, __) => SizedBox(key: smallKey),
        medium: (_, __) => SizedBox(key: mediumKey),
        large: (_, __) => SizedBox(key: largeKey),
      );

      widgetWithChild = ResponsiveLayoutBuilder(
        small: (_, child) => SizedBox(key: smallKey, child: child),
        medium: (_, child) => SizedBox(key: mediumKey, child: child),
        large: (_, child) => SizedBox(key: largeKey, child: child),
        child: (_) => SizedBox(key: childKey),
      );
    });

    testWidgets(
      'displays a large layout for sizes greater than large',
      (tester) async {
        tester.setDisplaySize(const Size(SudokuBreakpoint.large + 1, 1000));
        await tester.pumpApp(widgetWithoutChild);

        expect(find.byKey(smallKey), findsNothing);
        expect(find.byKey(mediumKey), findsNothing);
        expect(find.byKey(largeKey), findsOneWidget);
      },
    );

    group('on a large display', () {
      testWidgets('displays a large layout', (tester) async {
        tester.setLargeDisplaySize();
        await tester.pumpApp(widgetWithoutChild);

        expect(find.byKey(smallKey), findsNothing);
        expect(find.byKey(mediumKey), findsNothing);
        expect(find.byKey(largeKey), findsOneWidget);
      });

      testWidgets('displays child when available', (tester) async {
        tester.setLargeDisplaySize();
        await tester.pumpApp(widgetWithChild);

        expect(find.byKey(smallKey), findsNothing);
        expect(find.byKey(mediumKey), findsNothing);
        expect(find.byKey(largeKey), findsOneWidget);
        expect(find.byKey(childKey), findsOneWidget);
      });

      testWidgets('returns large layout size', (tester) async {
        tester.setLargeDisplaySize();

        ResponsiveLayoutSize? layoutSize;
        await tester.pumpApp(
          ResponsiveLayoutBuilder(
            small: (_, child) => child!,
            medium: (_, child) => child!,
            large: (_, child) => child!,
            child: (currentSize) {
              layoutSize = currentSize;
              return const SizedBox();
            },
          ),
        );

        expect(layoutSize, equals(ResponsiveLayoutSize.large));
      });
    });

    group('on a medium display', () {
      testWidgets('displays a medium layout', (tester) async {
        tester.setMediumDisplaySize();
        await tester.pumpApp(widgetWithoutChild);

        expect(find.byKey(smallKey), findsNothing);
        expect(find.byKey(mediumKey), findsOneWidget);
        expect(find.byKey(largeKey), findsNothing);
      });

      testWidgets('displays child when available', (tester) async {
        tester.setMediumDisplaySize();
        await tester.pumpApp(widgetWithChild);

        expect(find.byKey(smallKey), findsNothing);
        expect(find.byKey(mediumKey), findsOneWidget);
        expect(find.byKey(largeKey), findsNothing);
        expect(find.byKey(childKey), findsOneWidget);
      });

      testWidgets('returns medium layout size', (tester) async {
        tester.setMediumDisplaySize();

        ResponsiveLayoutSize? layoutSize;
        await tester.pumpApp(
          ResponsiveLayoutBuilder(
            small: (_, child) => child!,
            medium: (_, child) => child!,
            large: (_, child) => child!,
            child: (currentSize) {
              layoutSize = currentSize;
              return const SizedBox();
            },
          ),
        );

        expect(layoutSize, equals(ResponsiveLayoutSize.medium));
      });
    });

    group('on a small display', () {
      testWidgets('displays a small layout', (tester) async {
        tester.setSmallDisplaySize();
        await tester.pumpApp(widgetWithoutChild);

        expect(find.byKey(smallKey), findsOneWidget);
        expect(find.byKey(mediumKey), findsNothing);
        expect(find.byKey(largeKey), findsNothing);
      });

      testWidgets('displays child when available', (tester) async {
        tester.setSmallDisplaySize();
        await tester.pumpApp(widgetWithChild);

        expect(find.byKey(smallKey), findsOneWidget);
        expect(find.byKey(mediumKey), findsNothing);
        expect(find.byKey(largeKey), findsNothing);
        expect(find.byKey(childKey), findsOneWidget);
      });

      testWidgets('returns small layout size', (tester) async {
        tester.setSmallDisplaySize();

        ResponsiveLayoutSize? layoutSize;
        await tester.pumpApp(
          ResponsiveLayoutBuilder(
            small: (_, child) => child!,
            medium: (_, child) => child!,
            large: (_, child) => child!,
            child: (currentSize) {
              layoutSize = currentSize;
              return const SizedBox();
            },
          ),
        );

        expect(layoutSize, equals(ResponsiveLayoutSize.small));
      });
    });
  });
}
