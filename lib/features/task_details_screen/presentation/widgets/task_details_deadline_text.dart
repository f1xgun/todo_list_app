import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/core/styles/theme/bloc/theme_bloc.dart';
import 'package:todo_list_app/features/task_details_screen/presentation/bloc/task_details_bloc.dart';

class TaskDetailsDeadlineText extends StatelessWidget {
  const TaskDetailsDeadlineText({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final colors = context.read<ThemeBloc>().state.colorPalette;
    return BlocBuilder<TaskDetailsBloc, TaskDetailsState>(
      builder: (context, state) {
        final date = state.currentTask.deadline;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.deadlineTitle),
            if (date != null)
              Text(
                DateFormat('d MMMM yyyy', 'ru').format(date),
                style: text.bodyMedium?.copyWith(color: colors.colorBlue),
              )
          ],
        );
      },
    );
  }
}
