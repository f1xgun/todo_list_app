part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  const TasksState({required this.tasks, required this.completedVisible});

  final List<Task> tasks;
  final bool completedVisible;

  @override
  List<Object> get props => [tasks, completedVisible];
}
