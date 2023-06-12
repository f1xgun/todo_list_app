import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/core/utils/logger.dart';
import 'package:todo_list_app/features/home/presentation/widgets/home_screen_header.dart';
import 'package:todo_list_app/features/tasks/domain/task_model.dart';

import 'package:todo_list_app/features/tasks/presentation/bloc/tasks_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<TasksBloc, TasksState>(
          builder: (context, state) {
            logger.info(state);
            return CustomScrollView(
              slivers: [
                const SliverPersistentHeader(
                  delegate: HomeScreenHeaderDelegate(),
                  pinned: true,
                ),
                SliverToBoxAdapter(
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.tasks.length + 1,
                      itemBuilder: (context, index) {
                        if (index == state.tasks.length) {
                          return const ListTile(
                              title: Text('Добавить новую заметку'));
                        } else {
                          return ListTile(
                            title: Text(state.tasks[index].text),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => BlocProvider.of<TasksBloc>(context).add(
          AddTask(
            task: Task(
              text: BlocProvider.of<TasksBloc>(context)
                  .state
                  .tasks
                  .length
                  .toString(),
            ),
          ),
        ),
      ),
    );
  }
}
