import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sudoku/app_bloc_observer.dart';

/// The type definition for the builder widget.
typedef BootstrapBuilder = FutureOr<Widget> Function(
  FirebaseAuth firebaseAuth,
  FirebaseFirestore firestore,
);

/// Bootstrap is responsible for any common setup and calls
/// [runApp] with the widget returned by [builder] in an error zone.
Future<void> bootstrap(BootstrapBuilder builder) async {
  // Add Open Font License (OFL) for Inter google font
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/licenses/OFL.txt');
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
      runApp(
        await builder(
          FirebaseAuth.instance,
          FirebaseFirestore.instance,
        ),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
