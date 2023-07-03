import 'package:todo_list_app/core/managers/network_manager.dart';
import 'package:todo_list_app/core/managers/persistence_manager.dart';
import 'package:todo_list_app/features/tasks/data/api/network_storage_tasks_api.dart';
import 'package:todo_list_app/features/tasks/data/api/tasks_api.dart';
import 'package:todo_list_app/features/tasks/domain/response_data.dart';
import 'package:todo_list_app/features/tasks/domain/task_model.dart';

class TasksRepository {
  TasksRepository({
    required NetworkManager networkManager,
    required PersistenceManager persistenceManager,
    required this.localStorage,
  }) : _persistenceManager = persistenceManager {
    networkStorage = NetworkStorageTasksApi(
        persistenceManager: persistenceManager, networkManager: networkManager);
  }

  final PersistenceManager _persistenceManager;
  final TasksApi localStorage;
  late final NetworkStorageTasksApi networkStorage;

  Future<bool> checkChanges() async {
    final networkStorageTasks = (await networkStorage.getTasks()).data ?? [];
    final localTasks = await localStorage.getTasks();
    return !networkStorageTasks.every(localTasks.contains) ||
        !localTasks.every(networkStorageTasks.contains);
  }

  Future<void> syncStorages() async {
    final network = await networkStorage.getTasks();
    if (await _persistenceManager.getTasksRevision() != network.revision ||
        await checkChanges()) {
      await _persistenceManager.saveTasksRevision(
          revision: network.revision ?? 0);
      final localTasks = await getLocalTasks();

      if (network.data != null) {
        final localTasksMap = <String, Task>{
          for (var task in localTasks) task.id: task
        };
        for (final task in network.data!) {
          if (!localTasksMap.containsKey(task.id)) {
            await localStorage.addTask(task);
          } else {
            final tempTask = localTasksMap[task.id];
            if (tempTask!.changedAt.isBefore(task.changedAt)) {
              await localStorage.updateTask(task);
            } else if (tempTask.deleted != null && tempTask.deleted!) {
              await localStorage.deleteTask(tempTask.id);
            }
          }
        }
      }
      await networkStorage.syncTasks(await localStorage.getTasks());
    }
  }

  Future<List<Task>> getLocalTasks() async {
    final localTasks = await localStorage.getTasks();
    return localTasks;
  }

  Future<List<Task>> getTasks() async {
    await syncStorages();
    return getLocalTasks();
  }

  Future<Task> getTask(String id) async {
    await syncStorages();
    final localTask = await localStorage.getTask(id);
    return localTask;
  }

  Future<Task> addTask(Task task) async {
    final localTask = await localStorage.addTask(task);
    final ResponseData response = await networkStorage.addTask(task);
    if (response.status == 400) {
      await syncStorages();
      await networkStorage.addTask(task);
    }
    return localTask;
  }

  Future<Task> updateTask(Task task) async {
    final localTask = await localStorage.updateTask(task);
    final ResponseData response = await networkStorage.updateTask(task);
    if (response.status == 400) {
      await syncStorages();
      await networkStorage.updateTask(task);
    }
    return localTask;
  }

  Future<void> deleteTask(String id) async {
    await localStorage.deleteTaskWithoutInternet(id);
    final ResponseData response = await networkStorage.deleteTask(id);
    ResponseData? responseAfterSync;
    if (response.status == 400) {
      await syncStorages();
      responseAfterSync = await networkStorage.deleteTask(id);
    }
    if (response.status == 200 ||
        (responseAfterSync != null && responseAfterSync.status == 200)) {
      await localStorage.deleteTask(id);
    }
  }
}
