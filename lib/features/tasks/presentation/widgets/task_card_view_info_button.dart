import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list_app/core/data/managers/navigation_manager.dart';
import 'package:todo_list_app/core/presentation/styles/app_theme.dart';
import 'package:todo_list_app/features/tasks/domain/models/task_model.dart';

class TaskCardViewInfoButton extends StatelessWidget {
  const TaskCardViewInfoButton({required this.task, super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context).colors;
    final navigationManager = GetIt.I<NavigationManager>();

    return IconButton(
      icon: const Icon(Icons.info_outline),
      color: colors.colorLabelTertiary,
      onPressed: () => navigationManager.showTaskDetails(task.id),
    );
  }
}
