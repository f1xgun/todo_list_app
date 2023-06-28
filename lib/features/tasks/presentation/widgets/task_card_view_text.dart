import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/core/styles/app_theme.dart';
import 'package:todo_list_app/features/tasks/domain/task_model.dart';
import 'package:todo_list_app/features/tasks/presentation/widgets/task_card_view_text_title.dart';

class TaskCardViewText extends StatelessWidget {
  const TaskCardViewText({required this.task, super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final colors = AppTheme.of(context).colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TaskCardViewTextTitle(task: task),
        if (task.deadline != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              DateFormat.yMMMMd('ru-RU').format(task.deadline!),
              style: text.titleSmall?.copyWith(
                color: colors.colorLabelTertiary,
              ),
            ),
          ),
      ],
    );
  }
}
