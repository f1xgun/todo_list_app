import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/core/styles/theme/bloc/theme_bloc.dart';
import 'package:todo_list_app/features/tasks/domain/task_model.dart';
import 'package:todo_list_app/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:todo_list_app/features/tasks/presentation/widgets/task_card_view.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({required this.task, super.key});
  final Task task;

  @override
  Widget build(BuildContext context) {
    final colors = BlocProvider.of<ThemeBloc>(context).state.colorPalette;
    return Dismissible(
      key: ValueKey(task.id),
      child: TaskCardView(task: task),
      confirmDismiss: (direction) async {
        switch (direction) {
          case DismissDirection.endToStart:
            BlocProvider.of<TasksBloc>(context).add(DeleteTask(task: task));
            return true;
          case DismissDirection.startToEnd:
            BlocProvider.of<TasksBloc>(context)
                .add(UpdateTask(task: task.copyWith(isDone: true)));
            return false;
          default:
            return false;
        }
      },
      background: ColoredBox(
        color: colors.colorGreen,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Icon(Icons.check, color: colors.colorWhite),
            )
          ],
        ),
      ),
      secondaryBackground: ColoredBox(
        color: colors.colorRed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Icon(Icons.delete, color: colors.colorWhite),
            )
          ],
        ),
      ),
    );
  }
}
