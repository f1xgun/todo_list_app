import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  // Api
  @EnviedField(varName: 'TASKS_HOST', obfuscate: true)
  static final String tasksHost = _Env.tasksHost;
  @EnviedField(varName: 'TOKEN', obfuscate: true)
  static final String token = _Env.token;

  // Firebase
  // Web
  @EnviedField(varName: 'FIREBASE_WEB_API_KEY', obfuscate: true)
  static final String firebaseWebApiKey = _Env.firebaseWebApiKey;
  @EnviedField(varName: 'FIREBASE_WEB_APP_ID', obfuscate: true)
  static final String firebaseWebAppId = _Env.firebaseWebAppId;
  @EnviedField(varName: 'FIREBASE_WEB_MESSAGING_SENDER_ID', obfuscate: true)
  static final String firebaseWebMessagingSenderId =
      _Env.firebaseWebMessagingSenderId;
  @EnviedField(varName: 'FIREBASE_WEB_PROJECT_ID', obfuscate: true)
  static final String firebaseWebProjectId = _Env.firebaseWebProjectId;
  @EnviedField(varName: 'FIREBASE_WEB_AUTH_DOMAIN', obfuscate: true)
  static final String firebaseWebAuthDomain = _Env.firebaseWebAuthDomain;
  @EnviedField(varName: 'FIREBASE_WEB_STORAGE_BUCKET', obfuscate: true)
  static final String firebaseWebStorageBucket = _Env.firebaseWebStorageBucket;

  // Android
  @EnviedField(varName: 'FIREBASE_ANDROID_API_KEY', obfuscate: true)
  static final String firebaseAndroidApiKey = _Env.firebaseAndroidApiKey;
  @EnviedField(varName: 'FIREBASE_ANDROID_APP_ID', obfuscate: true)
  static final String firebaseAndoirdAppId = _Env.firebaseAndoirdAppId;
  @EnviedField(varName: 'FIREBASE_ANDROID_MESSAGING_SENDER_ID', obfuscate: true)
  static final String firebaseAndroidMessagingSenderId =
      _Env.firebaseAndroidMessagingSenderId;
  @EnviedField(varName: 'FIREBASE_ANDROID_PROJECT_ID', obfuscate: true)
  static final String firebaseAndroidProjectId = _Env.firebaseAndroidProjectId;
  @EnviedField(varName: 'FIREBASE_ANDROID_STORAGE_BUCKET', obfuscate: true)
  static final String firebaseAndroidStorageBucket =
      _Env.firebaseAndroidStorageBucket;

  // IOS
  @EnviedField(varName: 'FIREBASE_IOS_API_KEY', obfuscate: true)
  static final String firebaseIosApiKey = _Env.firebaseIosApiKey;
  @EnviedField(varName: 'FIREBASE_IOS_APP_ID', obfuscate: true)
  static final String firebaseIosAppId = _Env.firebaseIosAppId;
  @EnviedField(varName: 'FIREBASE_IOS_MESSAGING_SENDER_ID', obfuscate: true)
  static final String firebaseIosMessagingSenderId =
      _Env.firebaseIosMessagingSenderId;
  @EnviedField(varName: 'FIREBASE_IOS_PROJECT_ID', obfuscate: true)
  static final String firebaseIosProjectId = _Env.firebaseIosProjectId;
  @EnviedField(varName: 'FIREBASE_IOS_STORAGE_BUCKET', obfuscate: true)
  static final String firebaseIosStorageBucket = _Env.firebaseIosStorageBucket;
  @EnviedField(varName: 'FIREBASE_IOS_CLIENT_ID', obfuscate: true)
  static final String firebaseIosClientId = _Env.firebaseIosClientId;
  @EnviedField(varName: 'FIREBASE_IOS_BUNDLE_ID', obfuscate: true)
  static final String firebaseIosBundleId = _Env.firebaseIosBundleId;
}
