import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_list_app/core/presentation/styles/app_theme.dart';
import 'package:todo_list_app/features/home/presentation/widgets/home_screen_new_task_field.dart';
import 'package:todo_list_app/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:todo_list_app/features/tasks/presentation/task_card.dart';

class HomeScreenTaskList extends StatelessWidget {
  const HomeScreenTaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context).colors;
    return BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
      if (state.status == TasksStatus.loading) {
        return const SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state.status == TasksStatus.failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.loadTasksError),
            backgroundColor: colors.colorRed,
          ),
        );
        return const SizedBox();
      } else {
        final completedTasks =
            state.tasks.where((task) => task.isDone).toList();
        final noCompletedTasks =
            state.tasks.where((task) => !task.isDone).toList();
        final tasks = !state.completedVisible
            ? noCompletedTasks
            : [...noCompletedTasks, ...completedTasks];
        return SliverToBoxAdapter(
          child: Card(
            color: colors.colorBackSecondary,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tasks.length + 1,
                itemBuilder: (context, index) {
                  if (index == tasks.length) {
                    return Container(
                      padding: const EdgeInsets.fromLTRB(47, 7, 14, 7),
                      child: const HomeScreenNewTaskField(),
                    );
                  } else {
                    return TaskCard(task: tasks[index]);
                  }
                },
              ),
            ),
          ),
        );
      }
    });
  }
}
