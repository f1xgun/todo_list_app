import 'package:todo_list_app/features/tasks/domain/models/task_model.dart';

abstract class TasksApi {
  Future<List<Task>> getTasks();
  Future<Task> getTask(String id);
  Future<Task> addTask(Task task);
  Future<Task> updateTask(Task task);
  Future<void> deleteTask(String id);
  Future<void> deleteTaskWithoutInternet(String id);
}
