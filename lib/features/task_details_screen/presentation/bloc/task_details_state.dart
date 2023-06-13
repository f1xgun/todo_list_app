part of 'task_details_bloc.dart';

class TaskDetailsState extends Equatable {
  const TaskDetailsState({required this.currentTask});

  final Task currentTask;

  @override
  List<Object> get props => [currentTask];
}
