import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/widgets.dart';

class FirebaseConfigRepository {
  final FirebaseRemoteConfig _remoteConfig;

  late ValueNotifier<String> importantTaskColorNotifier =
      ValueNotifier(importantTaskColor);

  FirebaseConfigRepository(this._remoteConfig);

  String get importantTaskColor =>
      _remoteConfig.getString(_ConfigFields.importantTaskColor);

  Future<void> init() async {
    await _remoteConfig.setDefaults({
      _ConfigFields.importantTaskColor: '#FF3B30',
    });

    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(minutes: 1),
      ),
    );

    await _remoteConfig.fetchAndActivate();

    _remoteConfig.onConfigUpdated.listen((event) async {
      await _remoteConfig.activate();
      importantTaskColorNotifier.value = importantTaskColor;
    });
  }
}

abstract class _ConfigFields {
  static const importantTaskColor = 'important_task_color';
}
