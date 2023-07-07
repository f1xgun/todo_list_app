import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/features/tasks/domain/enums/importance.dart';
import 'package:todo_list_app/features/tasks/domain/models/task_model.dart';

part 'task_details_event.dart';
part 'task_details_state.dart';

class TaskDetailsBloc extends Bloc<TaskDetailsEvent, TaskDetailsState> {
  TaskDetailsBloc({required Task currentTask, required bool isNewTask})
      : super(
            TaskDetailsState(currentTask: currentTask, isNewTask: isNewTask)) {
    on<TaskDetailsUpdateText>(_onTaskDetailsUpdateText);
    on<TaskDetailsUpdateImportance>(_onTaskDetailsUpdateImportance);
    on<TaskDetailsUpdateDeadline>(_onTaskDetailsUpdateDeadline);
    on<TaskDetailsDeleteDeadline>(_onTaskDetailsDeleteDeadline);
  }

  Future<void> _onTaskDetailsUpdateText(
      TaskDetailsUpdateText event, Emitter<TaskDetailsState> emit) async {
    emit(state.copyWith(
        currentTask: state.currentTask.copyWith(text: event.text)));
  }

  Future<void> _onTaskDetailsUpdateImportance(
      TaskDetailsUpdateImportance event, Emitter<TaskDetailsState> emit) async {
    emit(state.copyWith(
        currentTask: state.currentTask.copyWith(importance: event.importance)));
  }

  Future<void> _onTaskDetailsUpdateDeadline(
      TaskDetailsUpdateDeadline event, Emitter<TaskDetailsState> emit) async {
    emit(state.copyWith(
        currentTask: state.currentTask.copyWith(deadline: event.deadline)));
  }

  Future<void> _onTaskDetailsDeleteDeadline(
      TaskDetailsDeleteDeadline event, Emitter<TaskDetailsState> emit) async {
    emit(state.copyWith(
        currentTask: state.currentTask.copyWith(deleted: true)));
  }
}
