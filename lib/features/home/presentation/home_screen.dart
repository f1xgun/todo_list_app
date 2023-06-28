import 'package:flutter/material.dart';
import 'package:todo_list_app/features/home/presentation/widgets/home_screen_floating_buttons.dart';

import 'package:todo_list_app/features/home/presentation/widgets/home_screen_header.dart';
import 'package:todo_list_app/features/home/presentation/widgets/home_screen_task_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
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
      floatingActionButton: HomeScreenFloatingButtons(),
    );
  }
}
