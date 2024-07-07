import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sudoku/app_bloc_observer.dart';

/// Bootstrap is responsible for any common setup and calls
/// [runApp] with the widget returned by [builder] in an error zone.
Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  // Add Open Font License (OFL) for Inter google font
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('licenses/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  // Log all uncaught build phase errors from the framework
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  // Log all uncaught asynchronous errors that aren't handled
  // by the Flutter framework.
  PlatformDispatcher.instance.onError = (error, stack) {
    log(error.toString(), stackTrace: stack);
    return true;
  };

  await runZonedGuarded(
    () async {
      Bloc.observer = const AppBlocObserver();
      runApp(await builder());
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
