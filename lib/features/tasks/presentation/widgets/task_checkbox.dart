import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/core/styles/theme/bloc/theme_bloc.dart';
import 'package:todo_list_app/features/tasks/domain/enums/importance.dart';
import 'package:todo_list_app/features/tasks/domain/task_model.dart';

class TaskCheckbox extends StatefulWidget {
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
  State<TaskCheckbox> createState() => _TaskCheckboxState();
}

class _TaskCheckboxState extends State<TaskCheckbox> {
  @override
  Widget build(BuildContext context) {
    final colors = BlocProvider.of<ThemeBloc>(context).state.colorPalette;
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color:
              !widget.value && widget.task.importance == Importance.highPriority
                  ? colors.colorRed.withOpacity(0.16)
                  : Colors.transparent,
        ),
        height: 18,
        width: 18,
        margin: const EdgeInsets.only(right: 15),
        child: Checkbox(
          value: widget.value,
          activeColor: colors.colorGreen,
          fillColor:
              !widget.value && widget.task.importance == Importance.highPriority
                  ? MaterialStateProperty.all(colors.colorRed)
                  : null,
          checkColor: colors.colorBackPrimary,
          onChanged: (_) {
            widget.onChanged(!widget.value);
          },
        ),
      ),
    );
  }
}
