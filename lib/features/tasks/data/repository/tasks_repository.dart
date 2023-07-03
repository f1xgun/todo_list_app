import 'package:todo_list_app/core/managers/persistence_manager.dart';
import 'package:todo_list_app/features/tasks/data/api/network_storage_tasks_api.dart';
import 'package:todo_list_app/features/tasks/data/api/tasks_api.dart';
import 'package:todo_list_app/features/tasks/domain/models/response_data.dart';
import 'package:todo_list_app/features/tasks/domain/models/task_model.dart';

class TasksRepository {
  TasksRepository(
      {required persistenceManager,
      required networkStorage,
      required localStorage})
      : _persistenceManager = persistenceManager,
        _networkStorage = networkStorage,
        _localStorage = localStorage;

  final PersistenceManager _persistenceManager;
  final TasksApi _localStorage;
  final NetworkStorageTasksApi _networkStorage;

  Future<bool> checkChanges() async {
    final networkStorageTasks = (await _networkStorage.getTasks()).data ?? [];
    final localTasks = await _localStorage.getTasks();
    return !networkStorageTasks.every(localTasks.contains) ||
        !localTasks.every(networkStorageTasks.contains);
  }

  Future<void> syncStorages() async {
    final network = await _networkStorage.getTasks();
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
            await _localStorage.addTask(task);
          } else {
            final tempTask = localTasksMap[task.id];
            if (tempTask!.changedAt.isBefore(task.changedAt)) {
              await _localStorage.updateTask(task);
            } else if (tempTask.deleted != null && tempTask.deleted!) {
              await _localStorage.deleteTask(tempTask.id);
            }
          }
        }
      }
      await _networkStorage.syncTasks(await _localStorage.getTasks());
    }
  }

  Future<List<Task>> getLocalTasks() async {
    final localTasks = await _localStorage.getTasks();
    return localTasks;
  }

  Future<List<Task>> getTasks() async {
    await syncStorages();
    return getLocalTasks();
  }

  Future<Task> getTask(String id) async {
    await syncStorages();
    final localTask = await _localStorage.getTask(id);
    return localTask;
  }

  Future<Task> addTask(Task task) async {
    final localTask = await _localStorage.addTask(task);
    final ResponseData response = await _networkStorage.addTask(task);
    if (response.status == 400) {
      await syncStorages();
      await _networkStorage.addTask(task);
    }
    return localTask;
  }

  Future<Task> updateTask(Task task) async {
    final localTask = await _localStorage.updateTask(task);
    final ResponseData response = await _networkStorage.updateTask(task);
    if (response.status == 400) {
      await syncStorages();
      await _networkStorage.updateTask(task);
    }
    return localTask;
  }

  Future<void> deleteTask(String id) async {
    await _localStorage.deleteTaskWithoutInternet(id);
    final ResponseData response = await _networkStorage.deleteTask(id);
    ResponseData? responseAfterSync;
    if (response.status == 400) {
      await syncStorages();
      responseAfterSync = await _networkStorage.deleteTask(id);
    }
    if (response.status == 200 ||
        (responseAfterSync != null && responseAfterSync.status == 200)) {
      await _localStorage.deleteTask(id);
    }
  }
}
