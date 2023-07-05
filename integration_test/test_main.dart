import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list_app/app.dart';
import 'package:todo_list_app/core/managers/network_manager.dart';
import 'package:todo_list_app/core/managers/persistence_manager.dart';
import 'package:todo_list_app/features/tasks/data/repository/tasks_repository.dart';
import 'package:todo_list_app/features/tasks/domain/api/local_tasks_api.dart';
import 'package:todo_list_app/features/tasks/domain/api/network_tasks_api.dart';

import '../test/test_doubles/local_tasks_api_mock.dart';
import '../test/test_doubles/network_manager_mock.mocks.dart';
import '../test/test_doubles/network_tasks_api_mock.dart';
import '../test/test_doubles/persistence_manager_mock.mocks.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initDependencies();
  runApp(
    MainApp(),
  );
}

Future<void> _initDependencies() async {
  final persistenceManager = MockPersistenceManager();
  when(persistenceManager.getTasksRevision()).thenAnswer((_) async => 0);
  when(persistenceManager.getDeviceId()).thenAnswer((_) async => 'example');
  GetIt.I.registerLazySingleton<LocalTasksApi>(MockLocalTasksApi.new);
  GetIt.I.registerLazySingleton<PersistenceManager>(() => persistenceManager);
  GetIt.I.registerLazySingleton<NetworkManager>(MockNetworkManager.new);
  GetIt.I.registerLazySingleton<NetworkTasksApi>(MockNetworkTasksApi.new);
  GetIt.I.registerLazySingleton<TasksRepository>(() => TasksRepository(
      localStorage: GetIt.I<LocalTasksApi>(),
      networkStorage: GetIt.I<NetworkTasksApi>(),
      persistenceManager: GetIt.I<PersistenceManager>()));
}
