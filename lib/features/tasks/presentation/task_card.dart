import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/core/utils/logger.dart';
import 'package:todo_list_app/features/tasks/domain/enums/importance.dart';
import 'package:todo_list_app/features/tasks/domain/task_model.dart';
import 'package:todo_list_app/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:todo_list_app/features/tasks/presentation/widgets/task_checkbox.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({required this.task, super.key});
  final Task task;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final text = themeData.textTheme;
    return Dismissible(
      key: ValueKey(task.id),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            TaskCheckbox(
              task: task,
              value: task.isDone,
              onChanged: (value) {
                BlocProvider.of<TasksBloc>(context)
                    .add(UpdateTask(task: task.copyWith(isDone: !task.isDone)));
                logger.info('${task.isDone ? 'Done' : 'Undone'} task');
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
                        if (task.importance == Importance.HighPriority)
                          WidgetSpan(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: SvgPicture.asset(
                                'assets/high_priority_importance.svg',
                                colorFilter: task.isDone
                                    ? ColorFilter.mode(
                                        themeData.hintColor,
                                        BlendMode.srcIn,
                                      )
                                    : const ColorFilter.mode(
                                        Colors.red,
                                        BlendMode.srcIn,
                                      ),
                              ),
                            ),
                          ),
                        if (task.importance == Importance.LowPriority)
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
                                    : const ColorFilter.mode(
                                        Colors.grey,
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
                                ? themeData.hintColor
                                : themeData.primaryColor,
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
                          color: themeData.hintColor,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const Icon(
              Icons.info_outline,
              color: Colors.grey,
            ),
          ],
        ),
      ),
      confirmDismiss: (direction) async {
        switch (direction) {
          case DismissDirection.endToStart:
            logger.info('delete task');
            BlocProvider.of<TasksBloc>(context).add(DeleteTask(task: task));
            return true;
          case DismissDirection.startToEnd:
            logger.info('done task');
            BlocProvider.of<TasksBloc>(context)
                .add(UpdateTask(task: task.copyWith(isDone: true)));
            return false;
          default:
            return false;
        }
      },
      background: const ColoredBox(
        color: Colors.green,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 24),
              child: Icon(Icons.check, color: Colors.white),
            )
          ],
        ),
      ),
      secondaryBackground: const ColoredBox(
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 24),
              child: Icon(Icons.delete, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
