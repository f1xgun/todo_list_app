import 'package:mockito/mockito.dart';
import 'package:todo_list_app/features/tasks/domain/api/network_tasks_api.dart';
import 'package:todo_list_app/features/tasks/domain/models/response_data.dart';
import 'package:todo_list_app/features/tasks/domain/models/task_model.dart';

class CustomMockNetworkTasksApi extends Mock implements NetworkTasksApi {
  List<Task> tasks = [];
  int revision = 1;

  void setTasks(List<Task> tasks) {
    this.tasks = tasks;
  }

  @override
  Future<ResponseData<Task>> addTask(Task task) async {
    tasks.add(task);
    return ResponseData(200, task, revision);
  }

  @override
  Future<ResponseData<Task>> deleteTask(String id) async {
    var task = tasks[0];
    final updatedTasks = <Task>[];
    for (final t in tasks) {
      if (t.id != id) {
        updatedTasks.add(t);
      } else {
        task = t;
      }
    }
    tasks = updatedTasks;
    return ResponseData(200, task, revision);
  }

  @override
  Future<ResponseData<List<Task>>> getTasks() async {
    return ResponseData(200, tasks, revision);
  }

  @override
  Future<ResponseData<Task>> updateTask(Task task) async {
    final updatedTasks = [
      for (final t in tasks)
        if (t.id == task.id) task else t
    ];
    tasks = updatedTasks;
    return ResponseData(200, task, revision);
  }

  @override
  Future<ResponseData<List<Task>>> syncTasks(List<Task> tasks) async {
    this.tasks = tasks;
    return ResponseData(200, this.tasks, revision);
  }
}
