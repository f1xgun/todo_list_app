import 'package:flutter/material.dart';
import 'package:todo_list_app/core/styles/app_theme.dart';
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
              ? colors.colorRed.withOpacity(0.16)
              : Colors.transparent,
        ),
        height: 18,
        width: 18,
        // margin: const EdgeInsets.only(right: 15),
        child: Checkbox(
          value: value,
          activeColor: colors.colorGreen,
          fillColor: !value && task.importance == Importance.highPriority
              ? MaterialStateProperty.all(colors.colorRed)
              : null,
          checkColor: colors.colorBackPrimary,
          onChanged: (_) {
            onChanged(!value);
          },
        ),
      ),
    );
  }
}
