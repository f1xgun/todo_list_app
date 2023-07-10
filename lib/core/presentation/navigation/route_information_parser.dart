import 'package:flutter/material.dart';
import 'package:todo_list_app/core/domain/constants/app_route_constants.dart';
import 'package:todo_list_app/core/presentation/navigation/navigation_state.dart';

class CustomRouteInformationParser
    extends RouteInformationParser<NavigationState> {
  @override
  Future<NavigationState> parseRouteInformation(
      RouteInformation routeInformation) async {
    final location = routeInformation.location;
    if (location == null) {
      return NavigationState.unkown();
    }

    final uri = Uri.parse(location);
    if (uri.pathSegments.isEmpty) {
      return NavigationState.root();
    }

    if (uri.pathSegments.length == 1) {
      if (uri.pathSegments[0] == AppRoutes.taskDetailsRoute) {
        return NavigationState.newTask();
      }

      return NavigationState.root();
    }

    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] == AppRoutes.taskDetailsRoute) {
        final taskId = uri.pathSegments[1];
        return NavigationState.taskDetails(taskId);
      }

      return NavigationState.unkown();
    }
    return NavigationState.root();
  }

  @override
  RouteInformation? restoreRouteInformation(NavigationState configuration) {
    if (configuration.isNewTaskScreen) {
      return const RouteInformation(location: '/${AppRoutes.taskDetailsRoute}');
    }

    if (configuration.isDetailsScreen) {
      return RouteInformation(
          location:
              '/${AppRoutes.taskDetailsRoute}/${configuration.selectedTaskId}');
    }

    if (configuration.isUnknown) {
      return null;
    }

    return const RouteInformation(location: '/${AppRoutes.homeRoute}');
  }
}
