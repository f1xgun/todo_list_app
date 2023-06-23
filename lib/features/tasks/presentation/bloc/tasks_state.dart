part of 'tasks_bloc.dart';

enum TasksStatus { initial, loading, success, failure }

class TasksState extends Equatable {
  const TasksState({
    this.tasks = const [],
    this.completedVisible = true,
    this.status = TasksStatus.initial,
  });

  final List<Task> tasks;
  final bool completedVisible;
  final TasksStatus status;

  TasksState copyWith(
      {List<Task>? tasks, bool? completedVisible, TasksStatus? status}) {
    return TasksState(
      tasks: tasks ?? this.tasks,
      completedVisible: completedVisible ?? this.completedVisible,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        tasks,
        completedVisible,
        status
      ];
}
