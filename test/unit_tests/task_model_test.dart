import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list_app/features/tasks/domain/enums/importance.dart';
import 'package:todo_list_app/features/tasks/domain/models/task_model.dart';

void main() {
  group('Test toJson task model method', () {
    test('Test toJson task model method #1', () {
      final task = Task(
          id: 'b31acb62-8f57-48e9-a38d-1da36588f188',
          text: 'task3',
          createdAt: DateTime.fromMillisecondsSinceEpoch(1687960438 * 1000),
          changedAt: DateTime.fromMillisecondsSinceEpoch(1688392329 * 1000),
          isDone: true,
          lastUpdatedBy: 'b1c83b24-f98e-4870-a6fd-4fcaaa42e077');

      expect(task.toJson(), {
        'id': 'b31acb62-8f57-48e9-a38d-1da36588f188',
        'created_at': 1687960438,
        'last_updated_by': 'b1c83b24-f98e-4870-a6fd-4fcaaa42e077',
        'done': true,
        'importance': 'basic',
        'text': 'task3',
        'changed_at': 1688392329,
        'deadline': null,
        'color': null
      });
    });

    test('Test toJson task model method #2', () {
      final task = Task(
          id: 'af1123a1-1c92-4c22-a8a2-1f87dde5d90a',
          text: 'task9',
          createdAt: DateTime.fromMillisecondsSinceEpoch(1688476560 * 1000),
          changedAt: DateTime.fromMillisecondsSinceEpoch(1688476560 * 1000),
          deadline: DateTime.fromMillisecondsSinceEpoch(1688601600 * 1000),
          lastUpdatedBy: '4c321394-fe01-419a-ad04-9f7c58daa94e',
          importance: Importance.lowPriority);

      expect(task.toJson(), {
        'id': 'af1123a1-1c92-4c22-a8a2-1f87dde5d90a',
        'deadline': 1688601600,
        'created_at': 1688476560,
        'last_updated_by': '4c321394-fe01-419a-ad04-9f7c58daa94e',
        'done': false,
        'importance': 'low',
        'text': 'task9',
        'changed_at': 1688476560,
        'color': null
      });
    });
  });

  group('Test fromJson task model method', () {
    test('Test fromJson task model method #1', () {
      final taskJson = <String, dynamic>{
        'id': 'b31acb62-8f57-48e9-a38d-1da36588f188',
        'created_at': 1687960438,
        'last_updated_by': 'b1c83b24-f98e-4870-a6fd-4fcaaa42e077',
        'done': true,
        'importance': 'basic',
        'text': 'task3',
        'changed_at': 1688392329,
        'deadline': null,
        'color': null
      };
      final task = Task(
          id: 'b31acb62-8f57-48e9-a38d-1da36588f188',
          text: 'task3',
          createdAt: DateTime.fromMillisecondsSinceEpoch(1687960438 * 1000),
          changedAt: DateTime.fromMillisecondsSinceEpoch(1688392329 * 1000),
          isDone: true,
          lastUpdatedBy: 'b1c83b24-f98e-4870-a6fd-4fcaaa42e077');

      expect(Task.fromJson(taskJson), task);
    });

    test('Test fromJson task model method #2', () {
      final taskJson = <String, dynamic>{
        'id': 'af1123a1-1c92-4c22-a8a2-1f87dde5d90a',
        'deadline': 1688601600,
        'created_at': 1688476560,
        'last_updated_by': '4c321394-fe01-419a-ad04-9f7c58daa94e',
        'done': false,
        'importance': 'low',
        'text': 'task9',
        'changed_at': 1688476560,
        'color': null
      };

      final task = Task(
          id: 'af1123a1-1c92-4c22-a8a2-1f87dde5d90a',
          text: 'task9',
          createdAt: DateTime.fromMillisecondsSinceEpoch(1688476560 * 1000),
          changedAt: DateTime.fromMillisecondsSinceEpoch(1688476560 * 1000),
          deadline: DateTime.fromMillisecondsSinceEpoch(1688601600 * 1000),
          lastUpdatedBy: '4c321394-fe01-419a-ad04-9f7c58daa94e',
          importance: Importance.lowPriority);

      expect(Task.fromJson(taskJson), task);
    });
  });
}
