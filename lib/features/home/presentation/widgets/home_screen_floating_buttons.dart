import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/core/styles/app_theme.dart';
import 'package:todo_list_app/features/tasks/presentation/bloc/tasks_bloc.dart';

class HomeScreenFloatingButtons extends StatelessWidget {
  const HomeScreenFloatingButtons(
      {required this.onNewTaskButtonTap, super.key});

  final void Function() onNewTaskButtonTap;

  @override
  Widget build(BuildContext context) {
    void refreshTasks() {
      context.read<TasksBloc>().add(const LoadTasks());
    }

    final colors = AppTheme.of(context).colors;

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
          heroTag: 'addTaskButton',
          backgroundColor: colors.colorBlue,
          child: Icon(color: colors.colorWhite, Icons.add),
          onPressed: onNewTaskButtonTap,
        ),
      ],
    );
  }
}
