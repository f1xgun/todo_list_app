// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      text: json['text'] as String,
      createdAt: const TimeStampConverter().fromJson(json['created_at'] as int),
      changedAt: const TimeStampConverter().fromJson(json['changed_at'] as int),
      id: json['id'] as String?,
      importance:
          $enumDecodeNullable(_$ImportanceEnumMap, json['importance']) ??
              Importance.none,
      isDone: const BoolOrIntToBoolConverter().fromJson(json['done'])!,
      deadline:
          const TimeStampOrNullConverter().fromJson(json['deadline'] as int?),
      color: json['color'] as String?,
      lastUpdatedBy: json['last_updated_by'] as String? ?? 'example',
      deleted: json['deleted'] == null
          ? false
          : const BoolOrIntToBoolConverter().fromJson(json['deleted']),
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'importance': _$ImportanceEnumMap[instance.importance]!,
      'done': instance.isDone,
      'deadline': const TimeStampOrNullConverter().toJson(instance.deadline),
      'color': instance.color,
      'created_at': const TimeStampConverter().toJson(instance.createdAt),
      'changed_at': const TimeStampConverter().toJson(instance.changedAt),
      'last_updated_by': instance.lastUpdatedBy,
    };

const _$ImportanceEnumMap = {
  Importance.none: 'basic',
  Importance.lowPriority: 'low',
  Importance.highPriority: 'important',
};
