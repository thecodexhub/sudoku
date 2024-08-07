// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sudoku/utilities/utilities.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

import 'helpers.dart';

class _FakeLaunchOptions extends Fake implements LaunchOptions {}

void main() {
  late UrlLauncherPlatform urlLauncher;

  setUp(() {
    urlLauncher = MockUrlLauncher();
    UrlLauncherPlatform.instance = urlLauncher;
  });

  setUpAll(() {
    registerFallbackValue(_FakeLaunchOptions());
  });

  group('openLink', () {
    final uri = Uri.parse('uri');
    final url = uri.toString();

    test('launches the link', () async {
      when(() => urlLauncher.canLaunch(url)).thenAnswer((_) async => true);
      when(() => urlLauncher.launchUrl(any(), any()))
          .thenAnswer((_) async => true);
      await openLink(uri);
      verify(
        () => urlLauncher.launchUrl(url, any()),
      ).called(1);
    });

    test('executes the onError callback when it cannot launch', () async {
      var wasCalled = false;
      when(() => urlLauncher.canLaunch(url)).thenAnswer((_) async => false);
      await openLink(uri,onError: () => wasCalled = true);

      await expectLater(wasCalled, isTrue);
    });
  });
}
