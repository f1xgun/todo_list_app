import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class PersistenceManager {
  static const _tasksRevisionKey = 'revision_key';
  static const _deviceIdKey = 'device_id_key';

  Future<int?> getTasksRevision() async {
    final instance = await SharedPreferences.getInstance();
    final data = instance.getInt(_tasksRevisionKey);
    return data;
  }

  Future<void> saveTasksRevision({required int revision}) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setInt(_tasksRevisionKey, revision);
  }

  Future<String?> getDeviceId() async {
    final instance = await SharedPreferences.getInstance();
    var data = instance.getString(_deviceIdKey);
    if (data == null) {
      await generateAndSaveDeviceId();
      data = instance.getString(_deviceIdKey);
    }
    return data;
  }

  Future<void> generateAndSaveDeviceId() async {
    final deviceId = const Uuid().v4();
    final instance = await SharedPreferences.getInstance();
    await instance.setString(_deviceIdKey, deviceId);
  }
}
