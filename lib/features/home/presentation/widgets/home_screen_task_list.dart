import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_list_app/core/styles/theme/bloc/theme_bloc.dart';
import 'package:todo_list_app/core/utils/logger.dart';
import 'package:todo_list_app/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:todo_list_app/features/tasks/presentation/task_card.dart';

class HomeScreenTaskList extends StatelessWidget {
  const HomeScreenTaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final tasksBloc = BlocProvider.of<TasksBloc>(context);
    final themeData = Theme.of(context);
    final text = themeData.textTheme;
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
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: AppLocalizations.of(context)!.addNewTaskText,
                    ),
                    style: text.bodyMedium
                        ?.copyWith(color: colors.colorLabelTertiary),
                  ),
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
