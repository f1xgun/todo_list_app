import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list_app/core/presentation/styles/app_theme.dart';
import 'package:todo_list_app/core/utils/analytics_logger.dart';
import 'package:todo_list_app/features/tasks/domain/enums/importance.dart';
import 'package:todo_list_app/features/tasks/domain/models/task_model.dart';

class TaskCheckbox extends StatelessWidget {
  const TaskCheckbox({
    required this.task,
    required this.onChanged,
    required this.value,
    super.key,
  });

  final Task task;
  final void Function(bool) onChanged;
  final bool value;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context).colors;
    return InkWell(
      radius: 18,
      child: Container(
        decoration: BoxDecoration(
          color: !value && task.importance == Importance.highPriority
              ? colors.colorImportantTask.withOpacity(0.16)
              : Colors.transparent,
        ),
        height: 18,
        width: 18,
        child: Checkbox(
          value: value,
          activeColor: colors.colorGreen,
          fillColor: !value && task.importance == Importance.highPriority
              ? MaterialStateProperty.all(colors.colorImportantTask)
              : null,
          checkColor: colors.colorBackPrimary,
          onChanged: (_) {
            onChanged(!value);
            GetIt.I<AnalyticsLogger>().doneTask(task);
          },
        ),
      ),
    );
  }
}
