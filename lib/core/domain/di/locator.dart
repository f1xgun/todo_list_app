import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app/core/config/firebase_config_repository.dart';
import 'package:todo_list_app/core/config/firebase_options.dart';
import 'package:todo_list_app/core/data/managers/navigation_manager.dart';
import 'package:todo_list_app/core/data/managers/network_manager.dart';
import 'package:todo_list_app/core/data/managers/persistence_manager.dart';
import 'package:todo_list_app/core/utils/logger.dart';
import 'package:todo_list_app/features/tasks/data/api/local_storage_tasks_api.dart';
import 'package:todo_list_app/features/tasks/data/api/network_storage_tasks_api.dart';
import 'package:todo_list_app/features/tasks/data/repository/tasks_repository.dart';
import 'package:todo_list_app/features/tasks/domain/api/local_tasks_api.dart';
import 'package:todo_list_app/features/tasks/domain/api/network_tasks_api.dart';

Future<void> initDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initFirebase();

  await _initApis();
  _initManagers();
  _initRepositories();
}

void _initManagers() {
  GetIt.I.registerLazySingleton<PersistenceManager>(() =>
      PersistenceManager(sharedPreferences: GetIt.I<SharedPreferences>()));

  GetIt.I.registerLazySingleton<NetworkManager>(
      () => NetworkManager(persistenceManager: GetIt.I<PersistenceManager>()));

  GetIt.I.registerLazySingleton<NavigationManager>(NavigationManager.new);
}

Future<void> _initApis() async {
  logger.info('LocalStorageTasksApi initialization started');
  final localStorage = LocalStorageTasksApi();
  await localStorage.init();
  logger.info('LocalStorageTasksApi initialized');
  GetIt.I.registerSingleton<LocalTasksApi>(localStorage);

  logger.info('SharedPreference initialization started');
  final shared = await SharedPreferences.getInstance();
  logger.info('SharedPreference initialized');
  GetIt.I.registerSingleton<SharedPreferences>(shared);

  GetIt.I.registerLazySingleton<NetworkTasksApi>(() => NetworkStorageTasksApi(
      networkManager: GetIt.I<NetworkManager>(),
      persistenceManager: GetIt.I<PersistenceManager>()));
}

void _initRepositories() {
  GetIt.I.registerLazySingleton<TasksRepository>(() => TasksRepository(
      localStorage: GetIt.I<LocalTasksApi>(),
      networkStorage: GetIt.I<NetworkTasksApi>(),
      persistenceManager: GetIt.I<PersistenceManager>()));
}

Future<void> _initFirebase() async {
  logger.info('Firebase initialization started');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  logger
    ..info('Firebase initialized')
    ..info('Firebase Remote Config initialization started');
  GetIt.I.registerLazySingleton<FirebaseRemoteConfig>(
      () => FirebaseRemoteConfig.instance);
  final config = FirebaseConfigRepository(GetIt.I<FirebaseRemoteConfig>());
  await config.init();
  GetIt.I.registerLazySingleton<FirebaseConfigRepository>(() => config);
  logger.info('Firebase Remote config initialized');
}

void initCrashlytics() {
  logger.info('Firebase Crashlytics initialization started');
  FlutterError.onError = (errorDetails) {
    logger.info('Caught error in FlutterError.onError');
    FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    logger.info('Caught error in PlatforDispatcher.onError');
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  logger.info('Firebase Crashlytics initialized');
}
