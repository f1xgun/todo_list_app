import 'package:flutter/material.dart';
import 'package:todo_list_app/core/styles/app_theme.dart';
import 'package:todo_list_app/features/tasks/domain/models/task_model.dart';

class TaskCardViewInfoButton extends StatelessWidget {
  const TaskCardViewInfoButton(
      {required this.task, required this.onTap, super.key});

  final Task task;
  final void Function(String taskId) onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context).colors;

    return IconButton(
      icon: const Icon(Icons.info_outline),
      color: colors.colorLabelTertiary,
      onPressed: () => onTap(task.id),
    );
  }
}
