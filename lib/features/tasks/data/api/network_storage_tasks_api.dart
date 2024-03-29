import 'package:todo_list_app/core/data/managers/network_manager.dart';
import 'package:todo_list_app/core/data/managers/persistence_manager.dart';
import 'package:todo_list_app/core/domain/error/exceptions.dart';
import 'package:todo_list_app/core/utils/logger.dart';
import 'package:todo_list_app/features/tasks/domain/api/network_tasks_api.dart';
import 'package:todo_list_app/features/tasks/domain/models/response_data.dart';
import 'package:todo_list_app/features/tasks/domain/models/task_model.dart';

class NetworkStorageTasksApi implements NetworkTasksApi {
  final NetworkManager _networkManager;
  final PersistenceManager _persistenceManager;

  NetworkStorageTasksApi({required networkManager, required persistenceManager})
      : _networkManager = networkManager,
        _persistenceManager = persistenceManager;

  @override
  Future<ResponseData<Task>> addTask(Task task) async {
    final requestData = <String, dynamic>{'element': task.toJson()};
    try {
      final response = await _networkManager.post('/list', requestData);
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = response.data;
        logger.info('Add task to network storage: ${task.toJson()}');
        final data = Task.fromJson(json['element']);

        final revision = json['revision'] as int;
        await _persistenceManager.saveTasksRevision(revision: revision);
        return ResponseData(response.statusCode!, data, revision);
      }
      return ResponseData.error(response.statusCode!);
    } on NoInternetException catch (e) {
      logger.info('Add task to network storage error: $e');
      return ResponseData.error(503);
    } on ResponseException catch (e) {
      logger.info('Add task to network storage error: $e');
      return ResponseData.error(404);
    } on UnknownNetworkException catch (e) {
      logger.info('Add task to network storage error: $e');
      return ResponseData.error(400);
    } on Exception catch (e) {
      logger.info('Add task to network storage error: $e');
      return ResponseData.error(500);
    }
  }

  @override
  Future<ResponseData<Task>> deleteTask(String id) async {
    try {
      final response = await _networkManager.delete('/list/$id');
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = response.data;
        logger.info(
            'Delete task from network storage: $id, ${response.statusMessage}');
        final data = Task.fromJson(json['element']);
        final revision = json['revision'] as int;
        await _persistenceManager.saveTasksRevision(revision: revision);
        return ResponseData(response.statusCode!, data, revision);
      }
      return ResponseData.error(response.statusCode!);
    } on NoInternetException catch (e) {
      logger.info('Delete task from network storage error: $e');
      return ResponseData.error(503);
    } on ResponseException catch (e) {
      logger.info('Delete task from network storage error: $e');
      return ResponseData.error(404);
    } on UnknownNetworkException catch (e) {
      logger.info('Delete task from network storage error: $e');
      return ResponseData.error(400);
    } on Exception catch (e) {
      logger.info('Delete task from network storage error: $e');
      return ResponseData.error(500);
    }
  }

  @override
  Future<ResponseData<Task>> getTask(String id) async {
    try {
      final response = await _networkManager.get('/list/$id');
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = response.data;
        logger.info(
            'Get task from network storage: $id, ${response.statusMessage}');
        final data = Task.fromJson(json['element']);

        final revision = json['revision'] as int;
        await _persistenceManager.saveTasksRevision(revision: revision);

        return ResponseData(response.statusCode!, data, revision);
      }
      return ResponseData.error(response.statusCode!);
    } on NoInternetException catch (e) {
      logger.info('Get task from network storage error: $e');
      return ResponseData.error(503);
    } on ResponseException catch (e) {
      logger.info('Get task from network storage error: $e');
      return ResponseData.error(404);
    } on UnknownNetworkException catch (e) {
      logger.info('Get task from network storage error: $e');
      return ResponseData.error(400);
    } on Exception catch (e) {
      logger.info('Get task from network storage error: $e');
      return ResponseData.error(500);
    }
  }

  @override
  Future<ResponseData<List<Task>>> getTasks() async {
    try {
      final response = await _networkManager.get('/list');

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = response.data;
        final listJson = json['list'] as List<dynamic>;
        final data = listJson
            .map((e) => Task.fromJson(e as Map<String, dynamic>))
            .toList();
        logger.info(
            'Get tasks from network storage: $data ${response.statusMessage}');

        final revision = json['revision'] as int;

        return ResponseData(response.statusCode!, data, revision);
      }
      return ResponseData.error(response.statusCode!);
    } on NoInternetException catch (e) {
      logger.info('Get tasks from network storage error: $e');
      return ResponseData.error(503);
    } on ResponseException catch (e) {
      logger.info('Get tasks from network storage error: $e');
      return ResponseData.error(404);
    } on UnknownNetworkException catch (e) {
      logger.info('Get tasks from network storage error: $e');
      return ResponseData.error(400);
    } on Exception catch (e) {
      logger.info('Get tasks from network storage error: $e');
      return ResponseData.error(500);
    }
  }

  @override
  Future<ResponseData<Task>> updateTask(Task task) async {
    final requestData = {'element': task.toJson()};
    try {
      final response =
          await _networkManager.put('/list/${task.id}', requestData);

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = response.data;
        logger.info(
            'Update task in network storage: $task ${response.statusMessage}');
        final data = Task.fromJson(json['element']);

        final revision = json['revision'] as int;
        await _persistenceManager.saveTasksRevision(revision: revision);

        return ResponseData(response.statusCode!, data, revision);
      }
      return ResponseData.error(response.statusCode!);
    } on NoInternetException catch (e) {
      logger.info('Update task in network storage error: $e');
      return ResponseData.error(503);
    } on ResponseException catch (e) {
      logger.info('Update task in network storage error: $e');
      return ResponseData.error(404);
    } on UnknownNetworkException catch (e) {
      logger.info('Update task in network storage error: $e');
      return ResponseData.error(400);
    } on Exception catch (e) {
      logger.info('Update task in network storage error: $e');
      return ResponseData.error(500);
    }
  }

  @override
  Future<ResponseData<List<Task>>> syncTasks(List<Task> tasks) async {
    final requestData = <String, dynamic>{
      'list': tasks.map((task) => task.toJson()).toList(),
    };
    try {
      final response = await _networkManager.patch('/list', requestData);

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = response.data;
        logger.info(
            'Sync tasks from network storage and local storage: ${response.statusMessage}');
        final listJson = json['list'] as List<dynamic>;
        final data = listJson
            .map((e) => Task.fromJson(e as Map<String, dynamic>))
            .toList();

        final revision = json['revision'] as int;
        await _persistenceManager.saveTasksRevision(revision: revision);

        return ResponseData(response.statusCode!, data, revision);
      }
      return ResponseData.error(response.statusCode!);
    } on NoInternetException catch (e) {
      logger.info('Sync tasks from network storage error: $e');
      return ResponseData.error(503);
    } on ResponseException catch (e) {
      logger.info('Sync tasks from network storage error: $e');
      return ResponseData.error(404);
    } on UnknownNetworkException catch (e) {
      logger.info('Sync tasks from network storage error: $e');
      return ResponseData.error(400);
    } on Exception catch (e) {
      logger.info('Sync tasks from network storage error: $e');
      return ResponseData.error(500);
    }
  }
}
