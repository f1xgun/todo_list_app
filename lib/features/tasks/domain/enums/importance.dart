import 'package:json_annotation/json_annotation.dart';

enum Importance {
  @JsonValue('none')
  none,
  @JsonValue('low')
  lowPriority,
  @JsonValue('high')
  highPriority
}
