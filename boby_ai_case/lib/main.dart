import 'dart:async';
import 'dart:developer';

import 'package:boby_ai_case/core/di/setup_injector.dart';
import 'package:boby_ai_case/core/setup/setup_bindings.dart';
import 'package:boby_ai_case/movie_app.dart';
import 'package:boby_ai_case/setup_environment.dart';
import 'package:flutter/material.dart';

void main() async {
  runZonedGuarded(
    () async {
      await Environment.setup();
      await setupBindings();
      await setupInjector();
      runApp(const MovieApp());
    },
    (error, stack) {
      // For debugging purposes
      log('Error: ${error.toString()}');
      log('Stack: ${stack.toString()}');
    },
  );
}
