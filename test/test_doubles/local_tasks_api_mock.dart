import 'package:mockito/mockito.dart';
import 'package:todo_list_app/features/tasks/domain/api/local_tasks_api.dart';
import 'package:todo_list_app/features/tasks/domain/models/task_model.dart';

class MockLocalTasksApi extends Mock implements LocalTasksApi {
  MockLocalTasksApi();

  List<Task> tasks = [];

  void setTasks(List<Task> tasks) {
    this.tasks = tasks;
  }

  @override
  Future<List<Task>> getTasks() async {
    return tasks;
  }

  @override
  Future<Task> addTask(Task task) async {
    tasks.add(task);
    return task;
  }

  @override
  Future<Task> updateTask(Task task) async {
    final updatedTasks = [
      for (final t in tasks)
        if (t.id == task.id) task else t
    ];
    tasks = updatedTasks;
    return task;
  }

  @override
  Future<void> deleteTask(String id) async {
    final updatedTasks = <Task>[
      for (final t in tasks)
        if (t.id != id) t
    ];

    tasks = updatedTasks;
  }
}
