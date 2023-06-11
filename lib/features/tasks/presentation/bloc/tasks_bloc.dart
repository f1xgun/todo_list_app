import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_list_app/features/tasks/domain/task_model.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState());

  @override
  Stream<TasksState> mapEventToState(
    TasksState currentState,
    TasksEvent event,
  ) async* {
    if (event is AddTask) {
      yield* _mapAddTaskToState(currentState, event);
    } else if (event is UpdateTask) {
      yield* _mapUpdateTaskToState(currentState, event);
    } else if (event is DeleteTask) {
      yield* _mapDeleteTaskToState(currentState, event);
    }
  }

  Stream<TasksState> _mapAddTaskToState(
      TasksState currentState, AddTask event) async* {
    final updatedTasks = List<Task>.from(currentState.tasks)..add(event.task);
    yield TasksLoaded(tasks: updatedTasks);
  }

  Stream<TasksState> _mapUpdateTaskToState(
      TasksState currentState, UpdateTask event) async* {
    if (currentState is TasksLoaded) {
      final updatedTasks = currentState.tasks.map((task) {
        return task.id == event.task.id ? event.task : task;
      }).toList();
      yield TasksLoaded(tasks: updatedTasks);
    }
  }

  Stream<TasksState> _mapDeleteTaskToState(
      TasksState currentState, DeleteTask event) async* {
    if (currentState is TasksLoaded) {
      final updatedTasks =
          currentState.tasks.where((task) => task.id != event.task.id).toList();
      yield TasksLoaded(tasks: updatedTasks);
    }
    final updatedTasks = List<Task>.from(currentState.tasks)..add(event.task);
    yield TasksLoaded(tasks: updatedTasks);
  }
}
