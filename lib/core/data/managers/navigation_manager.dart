import 'package:flutter/material.dart';
import 'package:todo_list_app/core/presentation/navigation/navigation_state.dart';
import 'package:todo_list_app/core/presentation/navigation/router_delegate.dart';
import 'package:todo_list_app/core/utils/analytics_logger.dart';

class NavigationManager {
  final AnalyticsLogger _analyticsLogger;
  final CustomRouterDelegate _routerDelegate;
  const NavigationManager(
      {required AnalyticsLogger analyticsLogger,
      required CustomRouterDelegate routerDelegate})
      : _analyticsLogger = analyticsLogger,
        _routerDelegate = routerDelegate;

  CustomRouterDelegate get routerDelegate => _routerDelegate;

  void showTaskDetails(String taskId) {
    _analyticsLogger.openPage('TaskDetails');
    _routerDelegate.setNewRoutePath(NavigationState.taskDetails(taskId));
  }

  void showNewTaskScreen() {
    _analyticsLogger.openPage('NewTask');
    _routerDelegate.setNewRoutePath(NavigationState.newTask());
  }

  void pop(BuildContext context) {
    Navigator.pop(context);
  }
}
