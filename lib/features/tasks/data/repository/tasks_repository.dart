import 'package:todo_list_app/core/utils/managers/persistence_manager.dart';
import 'package:todo_list_app/features/tasks/data/api/network_storage_tasks_api.dart';
import 'package:todo_list_app/features/tasks/data/api/tasks_api.dart';
import 'package:todo_list_app/features/tasks/domain/response_data.dart';
import 'package:todo_list_app/features/tasks/domain/task_model.dart';

class TasksRepository {
  TasksRepository({
    required this.localStorage,
  });

  final TasksApi localStorage;
  final NetworkStorageTasksApi networkStorage = NetworkStorageTasksApi();

  Future<bool> checkChanges() async {
    final networkStorageTasks = (await networkStorage.getTasks()).data ?? [];
    final localTasks = await localStorage.getTasks();
    return !networkStorageTasks.every(localTasks.contains) ||
        !localTasks.every(networkStorageTasks.contains);
  }

  Future<void> syncStorages() async {
    final networkRevision = (await networkStorage.getTasks()).revision;
    if (await PersistenceManager().getTasksRevision() != networkRevision || await checkChanges()) {
      final localTasks = await getLocalTasks();
      final syncTasksList = (await networkStorage.syncTasks(localTasks)).data;
      if (syncTasksList != null) {
        for (final task in syncTasksList) {
          if (localTasks
              .where((localTask) => localTask.id == task.id)
              .isEmpty) {
            await localStorage.addTask(task);
          } else {
            final tempTask =
                localTasks.firstWhere((localTask) => localTask.id == task.id);
            if (tempTask.changedAt.isBefore(task.changedAt)) {
              await localStorage.updateTask(task);
            }
          }
        }
      }
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
    if (response.revision != await PersistenceManager().getTasksRevision()) {
      await syncStorages();
      await networkStorage.addTask(task);
    }
    return localTask;
  }

  Future<Task> updateTask(Task task) async {
    final localTask = await localStorage.updateTask(task);
    final ResponseData response = await networkStorage.updateTask(task);
    if (response.revision != await PersistenceManager().getTasksRevision()) {
      await syncStorages();
      await networkStorage.updateTask(task);
    }
    return localTask;
  }

  Future<void> deleteTask(String id) async {
    await localStorage.deleteTask(id);
    final ResponseData response = await networkStorage.deleteTask(id);
    if (response.revision != await PersistenceManager().getTasksRevision()) {
      await syncStorages();
      await networkStorage.deleteTask(id);
    }
  }
}
