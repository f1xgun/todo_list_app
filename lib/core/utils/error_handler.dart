import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_app/core/domain/enums/environments.dart';

import 'package:todo_list_app/core/utils/logger.dart';

class ErrorHandler {
  const ErrorHandler._();

  static void init(Environment environment) {
    FlutterError.onError =
        (details) => _recordFlutterError(details, environment);
    logger.info('ErrorHandler initialized');
  }

  static void recordError(Object error, StackTrace stackTrace,
      {Environment? environment}) {
    if (environment == Environment.production) {
      FirebaseCrashlytics.instance.recordError(error, stackTrace);
    }
    logger.severe(
      error.toString(),
      error,
      stackTrace,
    );
  }

  static void _recordFlutterError(
      FlutterErrorDetails error, Environment environment) {
    if (environment == Environment.production) {
      FirebaseCrashlytics.instance.recordFlutterError(error, fatal: true);
    }
    logger.severe(error.toStringShort(), error.exception, error.stack);
  }
}
