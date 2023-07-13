import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/core/utils/logger.dart';
import 'package:todo_list_app/features/tasks/domain/models/task_model.dart';
import 'package:todo_list_app/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:todo_list_app/features/tasks/presentation/widgets/task_card_view_info_button.dart';
import 'package:todo_list_app/features/tasks/presentation/widgets/task_card_view_text.dart';
import 'package:todo_list_app/features/tasks/presentation/widgets/task_checkbox.dart';

class TaskCardView extends StatelessWidget {
  const TaskCardView({required this.task, required this.onTap, super.key});
  final Task task;
  final void Function(String taskId) onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: TaskCheckbox(
              task: task,
              value: task.isDone,
              onChanged: (value) {
                context.read<TasksBloc>().add(UpdateTask(
                    task: task.copyWith(
                        isDone: !task.isDone, changedAt: DateTime.now())));
                logger.info('${task.isDone ? 'Undone' : 'Done'} task');
              },
            ),
          ),
          Expanded(child: TaskCardViewText(task: task)),
          Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: TaskCardViewInfoButton(task: task, onTap: onTap),
          ),
        ],
      ),
    );
  }
}
