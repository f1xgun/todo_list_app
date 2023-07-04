import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list_app/features/tasks/data/repository/tasks_repository.dart';
import 'package:todo_list_app/features/tasks/domain/models/response_data.dart';
import 'package:todo_list_app/features/tasks/domain/models/task_model.dart';

import '../data/tasks.dart';
import '../test_doubles/local_tasks_api_mock.mocks.dart';
import '../test_doubles/network_tasks_api_mock.mocks.dart';
import '../test_doubles/persistence_manager_mock.mocks.dart';

void main() {
  late MockLocalTasksApi localStorage;
  late MockNetworkTasksApi networkStorage;
  late MockPersistenceManager persistenceManager;
  late TasksRepository repository;

  setUp(() async {
    localStorage = MockLocalTasksApi();
    networkStorage = MockNetworkTasksApi();
    persistenceManager = MockPersistenceManager();
    repository = TasksRepository(
        persistenceManager: persistenceManager,
        networkStorage: networkStorage,
        localStorage: localStorage);
  });

  test('Merge when storages have same revision and same tasks', () async {
    final tasks = mockTasks.map(Task.fromJson).toList();
    when(localStorage.getTasks()).thenAnswer((_) async => tasks);
    when(persistenceManager.getTasksRevision()).thenAnswer((_) async => 1);
    when(networkStorage.getTasks())
        .thenAnswer((_) async => ResponseData(200, tasks, 1));
    when(networkStorage.syncTasks(await localStorage.getTasks()))
        .thenAnswer((_) async => ResponseData(200, tasks, 1));

    expect(await repository.syncStorages(), tasks);
    verify(localStorage.getTasks());
    verifyNoMoreInteractions(localStorage);
    verify(networkStorage.getTasks());
    verifyNoMoreInteractions(networkStorage);
  });

  test('Merge when storages have same revision, but different tasks', () async {
    final tasks = mockTasks.map(Task.fromJson).toList();
    when(localStorage.getTasks()).thenAnswer((_) async => tasks);
    when(persistenceManager.getTasksRevision()).thenAnswer((_) async => 1);
    when(networkStorage.getTasks())
        .thenAnswer((_) async => ResponseData(200, tasks.sublist(2), 1));
    when(networkStorage.syncTasks(await localStorage.getTasks()))
        .thenAnswer((_) async => ResponseData(200, tasks, 2));

    expect(await repository.getTasks(), tasks);
    verify(localStorage.getTasks());
    verifyNoMoreInteractions(localStorage);
    verify(networkStorage.getTasks());
    verifyNoMoreInteractions(networkStorage);
  });

  // test('Merge when storages have different revision and different tasks',
  //     () async {
  //   final tasks = mockTasks.map(Task.fromJson).toList();
  //   when(localStorage.getTasks()).thenAnswer((_) async => tasks);
  //   when(persistenceManager.getTasksRevision()).thenAnswer((_) async => 1);
  //   when(networkStorage.getTasks())
  //       .thenAnswer((_) async => ResponseData(200, tasks.sublist(2), 2));
  //   when(networkStorage.syncTasks(await localStorage.getTasks()))
  //       .thenAnswer((_) async => ResponseData(200, tasks, 3));

  //   expect(await repository.getTasks(), tasks);
  // });

  // test('Merge when local storage has deleted tasks, which network storage has',
  //     () async {
  //   final localTasks = [mockTasks.map(Task.fromJson).first.copyWith(deleted: true)];
  //   final networkTasks = [mockTasks.map(Task.fromJson).first];
  //   when(localStorage.getTasks()).thenAnswer((_) async => localTasks);
  //   when(persistenceManager.getTasksRevision()).thenAnswer((_) async => 1);
  //   when(networkStorage.getTasks())
  //       .thenAnswer((_) async => ResponseData(200, networkTasks, 2));
  //   when(networkStorage.syncTasks())
  //       .thenAnswer((_) async => ResponseData(200, tasks, 3));

  //   expect(await repository.getTasks(), tasks);
  // });
}
