import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  // Api
  @EnviedField(varName: 'TASKS_HOST', obfuscate: true)
  static final String tasksHost = _Env.tasksHost;
  @EnviedField(varName: 'TOKEN', obfuscate: true)
  static final String token = _Env.token;
}