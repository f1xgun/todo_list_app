import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/core/styles/theme/bloc/theme_bloc.dart';
import 'package:todo_list_app/core/utils/logger.dart';
import 'package:todo_list_app/features/tasks/domain/enums/importance.dart';
import 'package:todo_list_app/features/tasks/domain/task_model.dart';
import 'package:todo_list_app/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:todo_list_app/features/tasks/presentation/widgets/task_checkbox.dart';

class TaskCardView extends StatelessWidget {
  const TaskCardView({required this.task, super.key});
  final Task task;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final text = themeData.textTheme;
    final colors = context.read<ThemeBloc>().state.colorPalette;
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Row(
        children: [
          TaskCheckbox(
            task: task,
            value: task.isDone,
            onChanged: (value) {
              context
                  .read<TasksBloc>()
                  .add(UpdateTask(task: task.copyWith(isDone: !task.isDone)));
              logger.info('${task.isDone ? 'Undone' : 'Done'} task');
            },
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      if (task.importance == Importance.highPriority)
                        WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: SvgPicture.asset(
                              'assets/high_priority_importance.svg',
                              colorFilter: task.isDone
                                  ? ColorFilter.mode(
                                      colors.colorLabelTertiary,
                                      BlendMode.srcIn,
                                    )
                                  : ColorFilter.mode(
                                      colors.colorRed,
                                      BlendMode.srcIn,
                                    ),
                            ),
                          ),
                        ),
                      if (task.importance == Importance.lowPriority)
                        WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: SvgPicture.asset(
                              'assets/low_priority_importance.svg',
                              colorFilter: task.isDone
                                  ? ColorFilter.mode(
                                      themeData.hintColor,
                                      BlendMode.srcIn,
                                    )
                                  : ColorFilter.mode(
                                      colors.colorGray,
                                      BlendMode.srcIn,
                                    ),
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
                ),
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: IconButton(
              icon: const Icon(Icons.info_outline),
              color: colors.colorLabelTertiary,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/task_details',
                  arguments: {'task': task, 'isNew': false},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
