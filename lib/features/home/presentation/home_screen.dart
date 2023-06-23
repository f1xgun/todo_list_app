import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/core/constants/app_route_constants.dart';
import 'package:todo_list_app/core/styles/theme/bloc/theme_bloc.dart';
import 'package:todo_list_app/core/utils/logger.dart';

import 'package:todo_list_app/features/home/presentation/widgets/home_screen_header.dart';
import 'package:todo_list_app/features/home/presentation/widgets/home_screen_task_list.dart';
import 'package:todo_list_app/features/tasks/domain/task_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.read<ThemeBloc>().state.colorPalette;
    return Scaffold(
      body: const SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: HomeScreenHeaderDelegate(),
              pinned: true,
            ),
            HomeScreenTaskList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colors.colorBlue,
        child: Icon(color: colors.colorWhite, Icons.add),
        onPressed: () {
          Navigator.pushNamed(
            context,
            AppRoutes.taskDetailRoute,
            arguments: {
              'task': Task(
                text: '',
                createdAt: DateTime.now(),
                changedAt: DateTime.now(),
              ),
              'isNew': true
            },
          );
          logger.info('Open task details page to create new task');
        },
      ),
    );
  }
}
