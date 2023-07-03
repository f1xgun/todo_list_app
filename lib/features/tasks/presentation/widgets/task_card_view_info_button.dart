import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/core/constants/app_route_constants.dart';
import 'package:todo_list_app/core/styles/theme/bloc/theme_bloc.dart';
import 'package:todo_list_app/core/utils/logger.dart';
import 'package:todo_list_app/features/tasks/domain/task_model.dart';

class TaskCardViewInfoButton extends StatelessWidget {
  const TaskCardViewInfoButton({required this.task, super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final colors = context.read<ThemeBloc>().state.colorPalette;

    return IconButton(
      icon: const Icon(Icons.info_outline),
      color: colors.colorLabelTertiary,
      onPressed: () {
        Navigator.pushNamed(
          context,
          AppRoutes.taskDetailRoute,
          arguments: {'task': task, 'isNew': false},
        );
        logger.info('Open task details page to edit task');
      },
    );
  }
}
