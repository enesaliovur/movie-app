import 'dart:async';
import 'dart:developer';

import 'package:boby_ai_case/core/config/app_flavor.dart';
import 'package:boby_ai_case/core/di/setup_injector.dart';
import 'package:boby_ai_case/core/setup/setup_bindings.dart';
import 'package:boby_ai_case/movie_app.dart';
import 'package:boby_ai_case/setup_environment.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void main() async {
  runZonedGuarded(
    () async {
      FlavorConfig.initialize(
        flavor: AppFlavor.prod,
        appName: 'Movie',
        baseUrl: 'https://api.themoviedb.org/3/',
        enableLogging: false,
      );

      await Environment.setup();
      await setupBindings();
      await setupInjector();
      await EasyLocalization.ensureInitialized();

      runApp(
        EasyLocalization(
          supportedLocales: const [Locale('en', 'US')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en', 'US'),
          child: const MovieApp(),
        ),
      );
    },
    (error, stack) {
      log('Error: ${error.toString()}');
      log('Stack: ${stack.toString()}');
    },
  );
}
