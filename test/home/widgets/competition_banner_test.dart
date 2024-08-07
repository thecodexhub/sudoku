// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sudoku/home/home.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

import '../../helpers/helpers.dart';

class _FakeLaunchOptions extends Fake implements LaunchOptions {}

void main() {
  group('CompetitionBanner', () {
    late UrlLauncherPlatform urlLauncher;

    setUp(() {
      urlLauncher = MockUrlLauncher();
      UrlLauncherPlatform.instance = urlLauncher;

      when(() => urlLauncher.canLaunch(any())).thenAnswer((_) async => true);
      when(() => urlLauncher.launchUrl(any(), any()))
          .thenAnswer((_) async => true);
    });

    setUpAll(() {
      registerFallbackValue(_FakeLaunchOptions());
    });

    testWidgets('renders an [OutlinedButton]', (tester) async {
      await tester.pumpApp(CompetitionBanner());
      expect(find.byType(OutlinedButton), findsOneWidget);
    });

    testWidgets('opens a link when tapped', (tester) async {
      await tester.pumpApp(CompetitionBanner());
      await tester.tap(find.byType(OutlinedButton));

      verify(
        () => urlLauncher.launchUrl(any(), any()),
      ).called(1);
    });
  });
}
