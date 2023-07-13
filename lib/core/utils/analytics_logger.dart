import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:todo_list_app/features/tasks/domain/models/task_model.dart';

abstract class AnalyticsLogger {
  static FirebaseAnalytics get analytics => FirebaseAnalytics.instance;

  static void addTask(Task task) {
    analytics.logEvent(name: 'add_task');
  }

  static void doneTask(Task task) {
    analytics.logEvent(name: '${task.isDone ? 'done' : 'undone'}_task');
  }

  static void updateTask(Task task) {
    analytics.logEvent(name: 'update_task');
  }

  static void deleteTask(Task task) {
    analytics.logEvent(name: 'Delete task');
  }

  static void openPage(String pageName) {
    analytics.logEvent(name: 'open_page_$pageName');
  }

  static void closePage(String pageName) {
    analytics.logEvent(name: 'close_page_$pageName');
  }

  static void toggleVisibilityTasksFilter(bool isVisible) {
    analytics.logEvent(
        name:
            'toggle_visibility_filter_tasks_${isVisible ? 'visible' : 'invisible'}');
  }
}
