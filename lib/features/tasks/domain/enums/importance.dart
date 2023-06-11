import 'package:json_annotation/json_annotation.dart';

enum Importance {
  @JsonValue('none')
  None,
  @JsonValue('low')
  LowPriority,
  @JsonValue('high')
  HighPriority
}
