import 'package:todo_list_app/core/presentation/navigation/navigation_state.dart';
import 'package:todo_list_app/core/presentation/navigation/router_delegate.dart';

class NavigationManager {
  final CustomRouterDelegate _routerDelegate = CustomRouterDelegate();

  CustomRouterDelegate get routerDelegate => _routerDelegate;

  void showTaskDetails(String taskId) {
    _routerDelegate.setNewRoutePath(NavigationState.taskDetails(taskId));
  }

  void showNewTaskScreen() {
    _routerDelegate.setNewRoutePath(NavigationState.newTask());
  }
}
