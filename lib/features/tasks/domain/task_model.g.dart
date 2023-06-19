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
              Importance.none,
      isDone: json['done'] as bool? ?? false,
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
      color: json['color'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      changedAt: json['changed_at'] == null
          ? null
          : DateTime.parse(json['changed_at'] as String),
      lastUpdatedBy: json['last_updated_by'] as String?,
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'importance': _$ImportanceEnumMap[instance.importance]!,
      'done': instance.isDone,
      'deadline': instance.deadline?.toIso8601String(),
      'color': instance.color,
      'created_at': instance.createdAt?.toIso8601String(),
      'changed_at': instance.changedAt?.toIso8601String(),
      'last_updated_by': instance.lastUpdatedBy,
    };

const _$ImportanceEnumMap = {
  Importance.none: 'basic',
  Importance.lowPriority: 'low',
  Importance.highPriority: 'important',
};
