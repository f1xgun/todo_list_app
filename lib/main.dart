import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list_app/app.dart';
import 'package:todo_list_app/core/managers/network_manager.dart';
import 'package:todo_list_app/core/managers/persistence_manager.dart';
import 'package:todo_list_app/core/utils/error_handler.dart';
import 'package:todo_list_app/core/utils/logger.dart';
import 'package:todo_list_app/features/tasks/data/api/local_storage_tasks_api.dart';
import 'package:todo_list_app/features/tasks/data/api/network_storage_tasks_api.dart';
import 'package:todo_list_app/features/tasks/data/api/tasks_api.dart';
import 'package:todo_list_app/features/tasks/data/repository/tasks_repository.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await configureDependencies();
    initLogger();

    logger.info('Start main');

    ErrorHandler.init();
    runApp(
      const MainApp(),
    );
  }, ErrorHandler.recordError);
}

Future<void> configureDependencies() async {
  final localStorage = LocalStorageTasksApi();
  await localStorage.init();
  GetIt.I.registerSingleton<TasksApi>(localStorage);
  GetIt.I.registerLazySingleton<PersistenceManager>(
      () => const PersistenceManager());
  GetIt.I.registerLazySingleton<NetworkManager>(
      () => NetworkManager(persistenceManager: GetIt.I<PersistenceManager>()));
  GetIt.I.registerLazySingleton<NetworkStorageTasksApi>(() =>
      NetworkStorageTasksApi(
          networkManager: GetIt.I<NetworkManager>(),
          persistenceManager: GetIt.I<PersistenceManager>()));
  GetIt.I.registerLazySingleton<TasksRepository>(() => TasksRepository(
      localStorage: GetIt.I<TasksApi>(),
      networkStorage: GetIt.I<NetworkStorageTasksApi>(),
      persistenceManager: GetIt.I<PersistenceManager>()));
}
