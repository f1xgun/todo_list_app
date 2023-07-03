import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_list_app/app.dart';
import 'package:todo_list_app/core/utils/error_handler.dart';
import 'package:todo_list_app/core/utils/logger.dart';
import 'package:todo_list_app/features/tasks/data/api/local_storage_tasks_api.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final localStorage = LocalStorageTasksApi();
    await localStorage.init();
    initLogger();
    logger.info('Start main');

    ErrorHandler.init();
    runApp(
      MainApp(localStorage: localStorage),
    );
  }, ErrorHandler.recordError);
}
