import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list_app/core/managers/navigation_manager.dart';
import 'package:todo_list_app/core/styles/app_theme.dart';
import 'package:todo_list_app/features/tasks/presentation/bloc/tasks_bloc.dart';

class HomeScreenFloatingButtons extends StatelessWidget {
  const HomeScreenFloatingButtons({super.key});

  @override
  Widget build(BuildContext context) {
    void refreshTasks() {
      context.read<TasksBloc>().add(const LoadTasks());
    }

    final colors = AppTheme.of(context).colors;
    final navigationManager = GetIt.I<NavigationManager>();

    return Row(
      children: [
        const SizedBox(width: 32),
        FloatingActionButton(
          heroTag: 'refreshTasksButton',
          onPressed: refreshTasks,
          backgroundColor: colors.colorBlue,
          child: Icon(color: colors.colorWhite, Icons.refresh),
        ),
        const Spacer(),
        FloatingActionButton(
          tooltip: 'Add new task',
          heroTag: 'addTaskButton',
          backgroundColor: colors.colorBlue,
          child: Icon(color: colors.colorWhite, Icons.add),
          onPressed: navigationManager.showNewTaskScreen,
        ),
      ],
    );
  }
}
