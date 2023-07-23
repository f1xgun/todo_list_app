import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_list_app/app.dart';
import 'package:todo_list_app/core/domain/di/locator.dart';
import 'package:todo_list_app/core/domain/enums/environments.dart';
import 'package:todo_list_app/core/utils/error_handler.dart';
import 'package:todo_list_app/core/utils/logger.dart';

Future<void> main() async {
  await runZonedGuarded(
    () async {
      await initDependencies();
      initCrashlytics();

      logger.info('Start main');

      ErrorHandler.init(Environment.production);
      runApp(
        MainApp(
          enviroment: Environment.production,
        ),
      );
    },
    (error, stackTrace) {
      ErrorHandler.recordError(error, stackTrace,
          environment: Environment.production);
    },
  );
}
