import 'package:flutter/material.dart';
import 'package:todo_list_app/core/navigation/navigation_state.dart';
import 'package:todo_list_app/features/home/presentation/home_screen.dart';
import 'package:todo_list_app/features/home/presentation/unknown_screen.dart';
import 'package:todo_list_app/features/task_details_screen/presentation/task_details_screen.dart';

class CustomRouterDelegate extends RouterDelegate<NavigationState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NavigationState> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  CustomRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  NavigationState? state;

  @override
  NavigationState get currentConfiguration {
    return state ?? NavigationState.root();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        const MaterialPage(
          child: HomeScreen(),
        ),
        if (state?.isDetailsScreen ?? false)
          MaterialPage(
            child: TaskDetailsScreen(
              taskId: state!.selectedTaskId!,
              isNewTask: false,
            ),
          ),
        if (state?.isUnknown ?? false)
          const MaterialPage(
            child: UnknownScreen(),
          ),
        if (state?.isNewTaskScreen ?? false)
          const MaterialPage(
            child: TaskDetailsScreen(
              taskId: 'unknown',
              isNewTask: true,
            ),
          )
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;

        state = NavigationState.root();

        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(NavigationState configuration) async {
    state = configuration;
    notifyListeners();
  }
}
