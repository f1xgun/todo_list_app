import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class PersistenceManager {
  final SharedPreferences _sharedPreferences;
  const PersistenceManager({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  // const PersistenceManager();

  static const _tasksRevisionKey = 'revision_key';
  static const _deviceIdKey = 'device_id_key';

  Future<int?> getTasksRevision() async {
    final data = _sharedPreferences.getInt(_tasksRevisionKey);
    return data;
  }

  Future<void> saveTasksRevision({required int revision}) async {
    await _sharedPreferences.setInt(_tasksRevisionKey, revision);
  }

  Future<String> getDeviceId() async {
    var data = _sharedPreferences.getString(_deviceIdKey);
    if (data == null) {
      await generateAndSaveDeviceId();
      data = _sharedPreferences.getString(_deviceIdKey);
    }
    return data ?? '';
  }

  Future<void> generateAndSaveDeviceId() async {
    final deviceId = const Uuid().v4();
    await _sharedPreferences.setString(_deviceIdKey, deviceId);
  }
}
