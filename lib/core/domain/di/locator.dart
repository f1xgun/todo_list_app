import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app/core/data/managers/navigation_manager.dart';
import 'package:todo_list_app/core/data/managers/network_manager.dart';
import 'package:todo_list_app/core/data/managers/persistence_manager.dart';
import 'package:todo_list_app/features/tasks/data/api/local_storage_tasks_api.dart';
import 'package:todo_list_app/features/tasks/data/api/network_storage_tasks_api.dart';
import 'package:todo_list_app/features/tasks/data/repository/tasks_repository.dart';
import 'package:todo_list_app/features/tasks/domain/api/local_tasks_api.dart';
import 'package:todo_list_app/features/tasks/domain/api/network_tasks_api.dart';

Future<void> initDependencies() async {
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
  final localStorage = LocalStorageTasksApi();
  await localStorage.init();
  GetIt.I.registerSingleton<LocalTasksApi>(localStorage);

  final shared = await SharedPreferences.getInstance();
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
