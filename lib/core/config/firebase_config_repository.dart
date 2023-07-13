import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseConfigRepository {
  final FirebaseRemoteConfig _remoteConfig;

  FirebaseConfigRepository(this._remoteConfig);

  String get importantTaskColor =>
      _remoteConfig.getString(_ConfigFields.importantTaskColor);

  Future<void> init() async {
    await _remoteConfig.setDefaults({
      _ConfigFields.importantTaskColor: '#FF3B30',
    });
    await _remoteConfig.fetchAndActivate();
  }
}

abstract class _ConfigFields {
  static const importantTaskColor = 'important_task_color';
}
