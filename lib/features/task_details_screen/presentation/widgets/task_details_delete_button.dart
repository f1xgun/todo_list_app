import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_list_app/core/presentation/styles/app_theme.dart';
import 'package:todo_list_app/features/task_details_screen/presentation/bloc/task_details_bloc.dart';
import 'package:todo_list_app/features/tasks/presentation/bloc/tasks_bloc.dart';

class TaskDetailsDeleteButton extends StatelessWidget {
  const TaskDetailsDeleteButton({required this.isNew, super.key});

  final bool isNew;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context).colors;
    final taskBloc = context.read<TaskDetailsBloc>();

    return TextButton.icon(
      style: TextButton.styleFrom(
        foregroundColor: isNew ? colors.colorLabelDisable : colors.colorRed,
      ),
      onPressed: isNew
          ? null
          : () {
              context
                  .read<TasksBloc>()
                  .add(DeleteTask(task: taskBloc.state.currentTask));
              Navigator.pop(context);
            },
      icon: const Icon(Icons.delete),
      label: Text(AppLocalizations.of(context)!.delete),
    );
  }
}
