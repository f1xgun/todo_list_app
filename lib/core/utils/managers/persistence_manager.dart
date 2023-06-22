import 'package:shared_preferences/shared_preferences.dart';

class PersistenceManager {
  static const _tasksRevisionKey = 'revision_key';

  Future<int?> getTasksRevision() async {
    final instance = await SharedPreferences.getInstance();
    final data = instance.getInt(_tasksRevisionKey);
    return data;
  }

  Future<void> saveTasksRevision({required int revision}) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setInt(_tasksRevisionKey, revision);
  }
}
