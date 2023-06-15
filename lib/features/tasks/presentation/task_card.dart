import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/core/styles/theme/bloc/theme_bloc.dart';
import 'package:todo_list_app/features/tasks/domain/task_model.dart';
import 'package:todo_list_app/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:todo_list_app/features/tasks/presentation/widgets/task_card_view.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({required this.task, super.key});
  final Task task;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  double swipeSize = 0;

  @override
  Widget build(BuildContext context) {
    final colors = BlocProvider.of<ThemeBloc>(context).state.colorPalette;
    final size = MediaQuery.of(context).size.width - 16;
    return Dismissible(
      key: ValueKey(widget.task.id),
      child: TaskCardView(task: widget.task),
      onUpdate: (details) {
        setState(() {
          swipeSize = details.progress * size;
        });
      },
      confirmDismiss: (direction) async {
        switch (direction) {
          case DismissDirection.endToStart:
            context.read<TasksBloc>().add(DeleteTask(task: widget.task));
            return true;
          case DismissDirection.startToEnd:
            context.read<TasksBloc>().add(UpdateTask(
                task: widget.task.copyWith(isDone: !widget.task.isDone)));
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
              padding: EdgeInsets.only(
                left: swipeSize > 48 ? swipeSize - 48 : 0,
              ),
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
              padding: EdgeInsets.only(
                right: swipeSize > 48 ? swipeSize - 48 : 0,
              ),
              child: Icon(Icons.delete, color: colors.colorWhite),
            ),
          ],
        ),
      ),
    );
  }
}
