import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/core/styles/theme/bloc/theme_bloc.dart';
import 'package:todo_list_app/core/utils/logger.dart';
import 'package:todo_list_app/features/home/presentation/widgets/home_screen_new_task_field.dart';
import 'package:todo_list_app/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:todo_list_app/features/tasks/presentation/task_card.dart';

class HomeScreenTaskList extends StatelessWidget {
  const HomeScreenTaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = BlocProvider.of<ThemeBloc>(context).state.colorPalette;
    logger.info(BlocProvider.of<ThemeBloc>(context).state.isDarkTheme);
    return BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
      final tasks = !state.completedVisible
          ? state.tasks.where((task) => !task.isDone).toList()
          : state.tasks;
      return SliverToBoxAdapter(
        child: Card(
          color: colors.colorBackSecondary,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tasks.length + 1,
            itemBuilder: (context, index) {
              if (index == tasks.length) {
                return Container(
                  padding: const EdgeInsets.fromLTRB(52, 14, 14, 14),
                  child: const HomeScreenNewTaskField(),
                );
              } else {
                return TaskCard(
                  task: tasks[index],
                );
              }
            },
          ),
        ),
      );
    });
  }
}
