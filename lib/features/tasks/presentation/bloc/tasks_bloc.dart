import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list_app/core/managers/persistence_manager.dart';
import 'package:todo_list_app/core/utils/logger.dart';
import 'package:todo_list_app/features/tasks/data/repository/tasks_repository.dart';
import 'package:todo_list_app/features/tasks/domain/models/task_model.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc()
      : _tasksRepository = GetIt.I<TasksRepository>(),
        _persistenceManager = GetIt.I<PersistenceManager>(),
        super(const TasksState()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<DeleteTask>(_onDeleteTask);
    on<UpdateTask>(_onUpdateTask);
    on<ToggleVisibilityCompletedFilter>(_onToggleVisibilityCompletedFilter);
  }

  final TasksRepository _tasksRepository;
  final PersistenceManager _persistenceManager;

  Future<void> _onLoadTasks(LoadTasks event, Emitter<TasksState> emit) async {
    emit(state.copyWith(status: TasksStatus.loading));
    try {
      final tasks = (await _tasksRepository.getTasks())
          .where((task) => !(task.deleted ?? false))
          .toList();
      emit(state.copyWith(tasks: tasks, status: TasksStatus.success));
      logger.info('Load tasks: ${tasks.length}');
    } on Exception catch (e) {
      emit(state.copyWith(status: TasksStatus.failure));
      logger.severe('Load tasks: $e');
    }
  }

  Future<void> _onAddTask(AddTask event, Emitter<TasksState> emit) async {
    final deviceId = await _persistenceManager.getDeviceId();
    final task = event.task.copyWith(lastUpdatedBy: deviceId);
    final updatedTasks = [...state.tasks, task];
    emit(state.copyWith(tasks: updatedTasks));
    logger.info('AddTask in temp array');
    try {
      await _tasksRepository.addTask(task);
      logger.info('AddTask to storages: $task');
    } on Exception catch (e) {
      logger.severe('AddTask: $e');
    }
  }

  Future<void> _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) async {
    final updatedTasks = [
      for (final t in state.tasks)
        if (t.id == event.task.id) event.task else t
    ];
    emit(state.copyWith(tasks: updatedTasks));
    logger.info('Update task in temp array');
    try {
      await _tasksRepository.updateTask(event.task);
      logger.info('Update task in storages: ${event.task}');
    } on Exception catch (e) {
      logger.info('Update task in storages: $e');
    }
  }

  Future<void> _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) async {
    final updatedTasks = [
      for (final t in state.tasks)
        if (t.id != event.task.id) t else null
    ];
    emit(state.copyWith(
        tasks: updatedTasks.where((t) => t != null).cast<Task>().toList()));
    logger.info('Delete task from temp array');
    try {
      await _tasksRepository.deleteTask(event.task.id);
      logger.info('Delete task from storages: ${event.task}');
    } on Exception catch (e) {
      logger.info('Delete task from storages: $e');
    }
  }

  Future<void> _onToggleVisibilityCompletedFilter(
      ToggleVisibilityCompletedFilter event, Emitter<TasksState> emit) async {
    emit(state.copyWith(completedVisible: !state.completedVisible));
    logger.info(
        'Toggle visibility tasks filter: completed tasks ${!state.completedVisible ? 'visible' : 'invisible'}');
  }
}
