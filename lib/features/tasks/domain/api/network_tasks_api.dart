import 'package:todo_list_app/features/tasks/domain/models/response_data.dart';
import 'package:todo_list_app/features/tasks/domain/models/task_model.dart';

abstract class NetworkTasksApi {
  Future<ResponseData<Task>> addTask(Task task);
  Future<ResponseData<Task>> deleteTask(String id);
  Future<ResponseData<Task>> getTask(String id);
  Future<ResponseData<List<Task>>> getTasks();
  Future<ResponseData<Task>> updateTask(Task task);
  Future<ResponseData<List<Task>>> syncTasks(List<Task> tasks);
}
