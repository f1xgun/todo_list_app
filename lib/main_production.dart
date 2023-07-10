import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_list_app/app.dart';
import 'package:todo_list_app/core/domain/di/locator.dart';
import 'package:todo_list_app/core/domain/enums/environments.dart';
import 'package:todo_list_app/core/utils/error_handler.dart';
import 'package:todo_list_app/core/utils/logger.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initDependencies();
    initLogger();

    logger.info('Start main');

    ErrorHandler.init();
    runApp(
      MainApp(
        enviroment: Environment.production,
      ),
    );
  }, ErrorHandler.recordError);
}
