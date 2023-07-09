import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list_app/app.dart';
import 'package:todo_list_app/core/managers/navigation_manager.dart';
import 'package:todo_list_app/core/managers/network_manager.dart';
import 'package:todo_list_app/core/managers/persistence_manager.dart';
import 'package:todo_list_app/core/utils/error_handler.dart';
import 'package:todo_list_app/core/utils/logger.dart';
import 'package:todo_list_app/features/tasks/data/api/local_storage_tasks_api.dart';
import 'package:todo_list_app/features/tasks/data/api/network_storage_tasks_api.dart';
import 'package:todo_list_app/features/tasks/data/repository/tasks_repository.dart';
import 'package:todo_list_app/features/tasks/domain/api/local_tasks_api.dart';
import 'package:todo_list_app/features/tasks/domain/api/network_tasks_api.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _initDependencies();
    initLogger();

    logger.info('Start main');

    ErrorHandler.init();
    runApp(
      MainApp(),
    );
  }, ErrorHandler.recordError);
}

Future<void> _initDependencies() async {
  final localStorage = LocalStorageTasksApi();
  await localStorage.init();
  GetIt.I.registerSingleton<LocalTasksApi>(localStorage);
  GetIt.I.registerLazySingleton<PersistenceManager>(
      () => const PersistenceManager());
  GetIt.I.registerLazySingleton<NetworkManager>(
      () => NetworkManager(persistenceManager: GetIt.I<PersistenceManager>()));
  GetIt.I.registerLazySingleton<NetworkTasksApi>(() => NetworkStorageTasksApi(
      networkManager: GetIt.I<NetworkManager>(),
      persistenceManager: GetIt.I<PersistenceManager>()));
  GetIt.I.registerLazySingleton<TasksRepository>(() => TasksRepository(
      localStorage: GetIt.I<LocalTasksApi>(),
      networkStorage: GetIt.I<NetworkTasksApi>(),
      persistenceManager: GetIt.I<PersistenceManager>()));
  GetIt.I.registerLazySingleton<NavigationManager>(NavigationManager.new);
}
