part of 'task_details_bloc.dart';

abstract class TaskDetailsEvent extends Equatable {
  const TaskDetailsEvent();

  @override
  List<Object> get props => [];
}

class TaskDetailsUpdateText extends TaskDetailsEvent {
  final String text;

  const TaskDetailsUpdateText({required this.text});

  @override
  List<Object> get props => [text];
}

class TaskDetailsUpdateImportance extends TaskDetailsEvent {
  final Importance importance;

  const TaskDetailsUpdateImportance({required this.importance});

  @override
  List<Object> get props => [importance];
}

class TaskDetailsUpdateDeadline extends TaskDetailsEvent {
  final DateTime deadline;

  const TaskDetailsUpdateDeadline({required this.deadline});

  @override
  List<Object> get props => [deadline];
}
