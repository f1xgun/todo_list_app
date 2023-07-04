import 'package:flutter/material.dart';
import 'package:todo_list_app/features/home/presentation/widgets/home_screen_floating_buttons.dart';

import 'package:todo_list_app/features/home/presentation/widgets/home_screen_header.dart';
import 'package:todo_list_app/features/home/presentation/widgets/home_screen_task_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen(
      {required this.onTaskTap, required this.onNewTaskButtonTap, super.key});

  final void Function(String taskId) onTaskTap;
  final void Function() onNewTaskButtonTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverPersistentHeader(
              delegate: HomeScreenHeaderDelegate(),
              pinned: true,
            ),
            HomeScreenTaskList(onTaskTap: onTaskTap),
          ],
        ),
      ),
      floatingActionButton: HomeScreenFloatingButtons(
        onNewTaskButtonTap: onNewTaskButtonTap,
      ),
    );
  }
}
