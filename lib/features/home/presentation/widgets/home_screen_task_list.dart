import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_list_app/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:todo_list_app/features/tasks/presentation/task_card.dart';

class HomeScreenTaskList extends StatelessWidget {
  const HomeScreenTaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final tasksBloc = BlocProvider.of<TasksBloc>(context);
    final themeData = Theme.of(context);
    final text = themeData.textTheme;
    return BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
      return SliverToBoxAdapter(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tasksBloc.state.tasks.length + 1,
            itemBuilder: (context, index) {
              if (index == tasksBloc.state.tasks.length) {
                return ListTile(
                  title: Text(
                    AppLocalizations.of(context)!.addNewTaskText,
                    style:
                        text.bodyMedium?.copyWith(color: themeData.hintColor),
                  ),
                );
              } else {
                return TaskCard(
                  task: tasksBloc.state.tasks[index],
                );
              }
            },
          ),
        ),
      );
    });
  }
}
