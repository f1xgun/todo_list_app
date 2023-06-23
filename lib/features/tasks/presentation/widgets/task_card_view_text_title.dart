import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/core/styles/theme/bloc/theme_bloc.dart';
import 'package:todo_list_app/features/tasks/domain/enums/importance.dart';
import 'package:todo_list_app/features/tasks/domain/task_model.dart';
import 'package:todo_list_app/features/tasks/presentation/widgets/task_card_view_importance_icon.dart';

class TaskCardViewTextTitle extends StatelessWidget {
  const TaskCardViewTextTitle({required this.task, super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final colors = context.read<ThemeBloc>().state.colorPalette;
    return RichText(
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          if (task.importance != Importance.none && !task.isDone)
            WidgetSpan(
              child: Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: TaskCardViewImportanceIcon(
                  importance: task.importance,
                ),
              ),
            ),
          TextSpan(
            text: task.text,
            style: text.bodyMedium?.copyWith(
              decoration: task.isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              color: task.isDone
                  ? colors.colorLabelTertiary
                  : colors.colorLabelPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
