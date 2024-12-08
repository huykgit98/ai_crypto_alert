import 'dart:async';
import 'dart:developer';

import 'package:ai_crypto_alert/app.dart';
import 'package:ai_crypto_alert/core/client/local/preferences_provider.dart';
import 'package:ai_crypto_alert/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> bootstrap() async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  await SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[DeviceOrientation.portraitUp],
  );
  final platformType = detectPlatformType();

  runApp(
    ProviderScope(
      overrides: [
        platformTypeProvider.overrideWithValue(platformType),
        sharedPrefsProvider.overrideWithValue(
          await SharedPreferences.getInstance(),
        ),
      ],
      observers: [
        Logger(),
      ],
      child: const App(),
    ),
  );
}
