import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/core/utils/logger.dart';
import 'package:todo_list_app/features/tasks/domain/task_model.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc()
      : super(const TasksState(
          completedVisible: true,
          tasks: <Task>[],
        )) {
    on<AddTask>(_onAddTask);
    on<DeleteTask>(_onDeleteTask);
    on<UpdateTask>(_onUpdateTask);
    on<ToggleVisibilityCompletedFilter>(_onToggleVisibilityCompletedFilter);
  }

  Future<void> _onAddTask(AddTask event, Emitter<TasksState> emit) async {
    final updatedTasks = List<Task>.from(state.tasks)..add(event.task);
    emit(
      TasksState(completedVisible: state.completedVisible, tasks: updatedTasks),
    );
    logger.info('AddTask: ${event.task}');
  }

  Future<void> _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) async {
    final updatedTasks = state.tasks.map((task) {
      return task.id == event.task.id ? event.task : task;
    }).toList();
    emit(
      TasksState(completedVisible: state.completedVisible, tasks: updatedTasks),
    );
    logger.info('Update task: ${event.task}');
  }

  Future<void> _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) async {
    final updatedTasks =
        state.tasks.where((task) => task.id != event.task.id).toList();
    emit(
      TasksState(completedVisible: state.completedVisible, tasks: updatedTasks),
    );
    logger.info('Delete task: ${event.task}');
  }

  Future<void> _onToggleVisibilityCompletedFilter(
      ToggleVisibilityCompletedFilter event, Emitter<TasksState> emit) async {
    emit(
      TasksState(completedVisible: !state.completedVisible, tasks: state.tasks),
    );
    logger.info(
        'Toggle visibility tasks filter: completed tasks ${!state.completedVisible ? 'visible' : 'invisible'}');
  }
}
