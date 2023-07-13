import 'package:todo_list_app/core/presentation/navigation/navigation_state.dart';
import 'package:todo_list_app/core/presentation/navigation/router_delegate.dart';
import 'package:todo_list_app/core/utils/analytics_logger.dart';

class NavigationManager {
  final CustomRouterDelegate _routerDelegate = CustomRouterDelegate();

  CustomRouterDelegate get routerDelegate => _routerDelegate;

  void showTaskDetails(String taskId) {
    AnalyticsLogger.openPage('TaskDetails');
    _routerDelegate.setNewRoutePath(NavigationState.taskDetails(taskId));
  }

  void showNewTaskScreen() {
    AnalyticsLogger.openPage('NewTask');
    _routerDelegate.setNewRoutePath(NavigationState.newTask());
  }
}
