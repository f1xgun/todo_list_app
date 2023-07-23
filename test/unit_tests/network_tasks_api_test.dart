import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list_app/core/domain/error/exceptions.dart';
import 'package:todo_list_app/features/tasks/data/api/network_storage_tasks_api.dart';
import 'package:todo_list_app/features/tasks/domain/models/response_data.dart';
import 'package:todo_list_app/features/tasks/domain/models/task_model.dart';

import '../data/tasks.dart';
import '../test_doubles/network_manager_mock.mocks.dart';
import '../test_doubles/persistence_manager_mock.mocks.dart';

void main() {
  late MockNetworkManager networkManager;
  late MockPersistenceManager persistenceManager;
  late NetworkStorageTasksApi networkTasksApi;

  setUp(() async {
    networkManager = MockNetworkManager();
    persistenceManager = MockPersistenceManager();
    networkTasksApi = NetworkStorageTasksApi(
        networkManager: networkManager, persistenceManager: persistenceManager);
  });

  group("Test addTask network storage's method", () {
    final task = Task.fromJson(mockTasks.first);
    test('Return task if the http call completes successfully', () async {
      when(networkManager.post('/list', {'element': task.toJson()})).thenAnswer(
          (_) async => Response(
              requestOptions: RequestOptions(),
              statusCode: 200,
              data: {'revision': 1, 'element': task.toJson(), 'status': 'ok'}));
      expect(await networkTasksApi.addTask(task), ResponseData(200, task, 1));
    });

    test('Return 503 status code when NoInternetException', () async {
      when(networkManager.post('/list', {'element': task.toJson()}))
          .thenAnswer((_) async => throw NoInternetException());
      expect(
          await networkTasksApi.addTask(task), ResponseData<Task>.error(503));
    });

    test('Return 500 status code when ResponseException', () async {
      when(networkManager.post('/list', {'element': task.toJson()}))
          .thenAnswer((_) async => throw ResponseException('Bad response'));
      expect(
          await networkTasksApi.addTask(task), ResponseData<Task>.error(404));
    });

    test('Return 400 status code when UnknownNetworkException', () async {
      when(networkManager.post('/list', {'element': task.toJson()}))
          .thenAnswer((_) async => throw UnknownNetworkException());
      expect(
          await networkTasksApi.addTask(task), ResponseData<Task>.error(400));
    });

    test('Return 500 status code when Exception', () async {
      when(networkManager.post('/list', {'element': task.toJson()}))
          .thenAnswer((_) async => throw Exception());
      expect(
          await networkTasksApi.addTask(task), ResponseData<Task>.error(500));
    });
  });

  group("Test deleteTask network storage's method", () {
    final task = Task.fromJson(mockTasks.first);
    test('Return task if the http call completes successfully', () async {
      when(networkManager.delete('/list/${task.id}')).thenAnswer((_) async =>
          Response(
              requestOptions: RequestOptions(),
              statusCode: 200,
              data: {'revision': 1, 'element': task.toJson(), 'status': 'ok'}));
      expect(await networkTasksApi.deleteTask(task.id),
          ResponseData(200, task, 1));
    });

    test('Return 503 status code when NoInternetException', () async {
      when(networkManager.delete('/list/${task.id}'))
          .thenAnswer((_) async => throw NoInternetException());
      expect(await networkTasksApi.deleteTask(task.id),
          ResponseData<Task>.error(503));
    });

    test('Return 404 status code when ResponseException', () async {
      when(networkManager.delete('/list/${task.id}'))
          .thenAnswer((_) async => throw ResponseException('Bad response'));
      expect(await networkTasksApi.deleteTask(task.id),
          ResponseData<Task>.error(404));
    });

    test('Return 400 status code when UnknownNetworkException', () async {
      when(networkManager.delete('/list/${task.id}'))
          .thenAnswer((_) async => throw UnknownNetworkException());
      expect(await networkTasksApi.deleteTask(task.id),
          ResponseData<Task>.error(400));
    });

    test('Return 500 status code when Exception', () async {
      when(networkManager.delete('/list/${task.id}'))
          .thenAnswer((_) async => throw Exception());
      expect(await networkTasksApi.deleteTask(task.id),
          ResponseData<Task>.error(500));
    });
  });

  group("Test getTask network storage's method", () {
    final task = Task.fromJson(mockTasks.first);
    test('Return task if the http call completes successfully', () async {
      when(networkManager.get('/list/${task.id}')).thenAnswer((_) async =>
          Response(
              requestOptions: RequestOptions(),
              statusCode: 200,
              data: {'revision': 1, 'element': task.toJson(), 'status': 'ok'}));
      expect(
          await networkTasksApi.getTask(task.id), ResponseData(200, task, 1));
    });

    test('Return 503 status code when NoInternetException', () async {
      when(networkManager.get('/list/${task.id}'))
          .thenAnswer((_) async => throw NoInternetException());
      expect(await networkTasksApi.getTask(task.id),
          ResponseData<Task>.error(503));
    });

    test('Return 404 status code when ResponseException', () async {
      when(networkManager.get('/list/${task.id}'))
          .thenAnswer((_) async => throw ResponseException('Bad response'));
      expect(await networkTasksApi.getTask(task.id),
          ResponseData<Task>.error(404));
    });

    test('Return 400 status code when UnknownNetworkException', () async {
      when(networkManager.get('/list/${task.id}'))
          .thenAnswer((_) async => throw UnknownNetworkException());
      expect(await networkTasksApi.getTask(task.id),
          ResponseData<Task>.error(400));
    });

    test('Return 500 status code when Exception', () async {
      when(networkManager.get('/list/${task.id}'))
          .thenAnswer((_) async => throw Exception());
      expect(await networkTasksApi.getTask(task.id),
          ResponseData<Task>.error(500));
    });
  });

  group("Test getTasks network storage's method", () {
    final tasks = mockTasks.map(Task.fromJson).toList();
    test('Return list of tasks if the http call completes successfully',
        () async {
      when(networkManager.get('/list')).thenAnswer((_) async =>
          Response(requestOptions: RequestOptions(), statusCode: 200, data: {
            'revision': 1,
            'list': tasks.map((task) => task.toJson()).toList(),
            'status': 'ok'
          }));
      expect(await networkTasksApi.getTasks(), ResponseData(200, tasks, 1));
    });

    test('Return 503 status code when NoInternetException', () async {
      when(networkManager.get('/list'))
          .thenAnswer((_) async => throw NoInternetException());
      expect(await networkTasksApi.getTasks(),
          ResponseData<List<Task>>.error(503));
    });

    test('Return 404 status code when ResponseException', () async {
      when(networkManager.get('/list'))
          .thenAnswer((_) async => throw ResponseException('Bad response'));
      expect(await networkTasksApi.getTasks(),
          ResponseData<List<Task>>.error(404));
    });

    test('Return 400 status code when UnknownNetworkException', () async {
      when(networkManager.get('/list'))
          .thenAnswer((_) async => throw UnknownNetworkException());
      expect(await networkTasksApi.getTasks(),
          ResponseData<List<Task>>.error(400));
    });

    test('Return 500 status code when Exception', () async {
      when(networkManager.get('/list'))
          .thenAnswer((_) async => throw Exception());
      expect(await networkTasksApi.getTasks(),
          ResponseData<List<Task>>.error(500));
    });
  });

  group("Test updateTask network storage's method", () {
    final task = Task.fromJson(mockTasks.first);
    test('Return task if the http call completes successfully', () async {
      when(networkManager.put('/list/${task.id}', {'element': task.toJson()}))
          .thenAnswer((_) async => Response(
              requestOptions: RequestOptions(),
              statusCode: 200,
              data: {'revision': 1, 'element': task.toJson(), 'status': 'ok'}));
      expect(
          await networkTasksApi.updateTask(task), ResponseData(200, task, 1));
    });

    test('Return 503 status code when NoInternetException', () async {
      when(networkManager.put('/list/${task.id}', {'element': task.toJson()}))
          .thenAnswer((_) async => throw NoInternetException());
      expect(await networkTasksApi.updateTask(task),
          ResponseData<Task>.error(503));
    });

    test('Return 404 status code when ResponseException', () async {
      when(networkManager.put('/list/${task.id}', {'element': task.toJson()}))
          .thenAnswer((_) async => throw ResponseException('Bad response'));
      expect(await networkTasksApi.updateTask(task),
          ResponseData<Task>.error(404));
    });

    test('Return 400 status code when UnknownNetworkException', () async {
      when(networkManager.put('/list/${task.id}', {'element': task.toJson()}))
          .thenAnswer((_) async => throw UnknownNetworkException());
      expect(await networkTasksApi.updateTask(task),
          ResponseData<Task>.error(400));
    });

    test('Return 500 status code when Exception', () async {
      when(networkManager.put('/list/${task.id}', {'element': task.toJson()}))
          .thenAnswer((_) async => throw Exception());
      expect(await networkTasksApi.updateTask(task),
          ResponseData<Task>.error(500));
    });
  });
}
