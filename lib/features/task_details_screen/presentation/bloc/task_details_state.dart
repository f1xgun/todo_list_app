part of 'task_details_bloc.dart';

class TaskDetailsState extends Equatable {
  const TaskDetailsState({required this.currentTask, required this.isNewTask});

  final bool isNewTask;
  final Task currentTask;

  TaskDetailsState copyWith({Task? currentTask, bool? isNewTask}) {
    return TaskDetailsState(
        currentTask: currentTask ?? this.currentTask,
        isNewTask: isNewTask ?? this.isNewTask);
  }

  @override
  List<Object> get props => [currentTask, isNewTask];
}
