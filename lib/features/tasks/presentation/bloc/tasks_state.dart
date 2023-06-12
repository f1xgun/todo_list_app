part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  const TasksState({required this.tasks});

  final List<Task> tasks;

  @override
  List<Object> get props => [tasks];
}
