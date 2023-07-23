import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:todo_list_app/features/tasks/domain/models/task_model.dart';

class AnalyticsLogger {
  const AnalyticsLogger();

  FirebaseAnalytics get analytics => FirebaseAnalytics.instance;

  void addTask(Task task) {
    analytics.logEvent(name: 'add_task');
  }

  void doneTask(Task task) {
    analytics.logEvent(name: '${task.isDone ? 'done' : 'undone'}_task');
  }

  void updateTask(Task task) {
    analytics.logEvent(name: 'update_task');
  }

  void deleteTask(Task task) {
    analytics.logEvent(name: 'Delete task');
  }

  void openPage(String pageName) {
    analytics.logEvent(name: 'open_page_$pageName');
  }

  void closePage(String pageName) {
    analytics.logEvent(name: 'close_page_$pageName');
  }

  void toggleVisibilityTasksFilter(bool isVisible) {
    analytics.logEvent(
        name:
            'toggle_visibility_filter_tasks_${isVisible ? 'visible' : 'invisible'}');
  }
}
