// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      text: json['text'] as String,
      id: json['id'] as String?,
      importance:
          $enumDecodeNullable(_$ImportanceEnumMap, json['importance']) ??
              Importance.None,
      isDone: json['isDone'] as bool? ?? false,
      isDeleted: json['isDeleted'] as bool? ?? false,
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'importance': _$ImportanceEnumMap[instance.importance]!,
      'isDone': instance.isDone,
      'isDeleted': instance.isDeleted,
      'deadline': instance.deadline?.toIso8601String(),
    };

const _$ImportanceEnumMap = {
  Importance.None: 'none',
  Importance.LowPriority: 'low',
  Importance.HighPriority: 'high',
};
