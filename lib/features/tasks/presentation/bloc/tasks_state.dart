part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final List<Task> tasks;
  const TasksState([this.tasks = const <Task>[]]);

  @override
  List<Object> get props => [tasks];
}

class TasksLoading extends TasksState {}

class TasksLoaded extends TasksState {
  @override
  final List<Task> tasks;
  const TasksLoaded({required this.tasks}) : super(tasks);
}

class TasksNotLoaded extends TasksState {}
