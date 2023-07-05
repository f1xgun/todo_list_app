import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list_app/features/tasks/data/repository/tasks_repository.dart';
import 'package:todo_list_app/features/tasks/domain/models/task_model.dart';

import '../data/tasks.dart';
import '../test_doubles/local_tasks_api_mock.dart';
import '../test_doubles/network_tasks_api_mock.dart';
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

  group('Test merge tasks from local and network storages', () {
    test('Merge when storages have same revision and same tasks', () async {
      final tasks = mockTasks.map(Task.fromJson).toList();
      localStorage.setTasks(tasks);
      networkStorage.setTasks(tasks);
      when(persistenceManager.getTasksRevision()).thenAnswer((_) async => 1);

      expect(await repository.syncStorages(), tasks);
    });

    test(
        'Merge when storages have same revision, but different tasks '
        'Local storage has more new tasks', () async {
      final tasks = mockTasks.map(Task.fromJson).toList();
      localStorage.setTasks(tasks);
      networkStorage.setTasks(tasks.sublist(2));

      when(persistenceManager.getTasksRevision()).thenAnswer((_) async => 1);

      expect(await repository.syncStorages(), unorderedEquals(tasks));
    });

    test(
        'Merge when storages have same revision, but different tasks '
        'Network storage has more tasks', () async {
      final tasks = mockTasks.map(Task.fromJson).toList();
      localStorage.setTasks(tasks.sublist(2));
      networkStorage.setTasks(tasks);

      when(persistenceManager.getTasksRevision()).thenAnswer((_) async => 1);

      expect(await repository.syncStorages(), unorderedEquals(tasks));
    });

    test(
        'Merge when storages have different revision and different tasks '
        'Local storage has more new tasks', () async {
      final tasks = mockTasks.map(Task.fromJson).toList();
      localStorage.setTasks(tasks);
      networkStorage.setTasks(tasks.sublist(3));
      when(persistenceManager.getTasksRevision()).thenAnswer((_) async => 0);

      expect(await repository.syncStorages(), unorderedEquals(tasks));
    });

    test(
        'Merge when storages have different revision and different tasks '
        'Network storage has more tasks', () async {
      final tasks = mockTasks.map(Task.fromJson).toList();
      localStorage.setTasks(tasks.sublist(3));
      networkStorage.setTasks(tasks);
      when(persistenceManager.getTasksRevision()).thenAnswer((_) async => 0);

      expect(await repository.syncStorages(), unorderedEquals(tasks));
    });

    test(
        'Merge when local storage has deleted tasks, which network storage has',
        () async {
      final localTasks = [
        mockTasks.map(Task.fromJson).first.copyWith(deleted: true)
      ];
      final networkTasks = [mockTasks.map(Task.fromJson).first];
      localStorage.setTasks(localTasks);
      networkStorage.setTasks(networkTasks);
      when(persistenceManager.getTasksRevision()).thenAnswer((_) async => 1);

      expect(await repository.syncStorages(), []);
    });
  });
}
