import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/widgets.dart';
import 'package:wordle/components/my_app.dart';
import 'package:wordle/config.dart';
import 'package:wordle/utils/constants.dart';

Future<void> initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "Wordle",
      options: const FirebaseOptions(
    apiKey: apiKey,
    appId: appId,
    messagingSenderId: messagingSenderId,
    projectId: projectId,
  ));

  Config.setupRemoteConfig();
  if (Platform.isAndroid || Platform.isIOS) {
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    // Pass all uncaught errors from the framework to Crashlytics.
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    runZonedGuarded(() {
      runApp(const MyApp());
    }, FirebaseCrashlytics.instance.recordError);
  } else {
    runApp(const MyApp());
  }
}
