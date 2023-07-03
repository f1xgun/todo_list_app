import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:todo_list_app/features/tasks/domain/enums/importance.dart';
import 'package:uuid/uuid.dart';

part 'task_model.g.dart';

extension TaskMapExtension on Map<String, dynamic> {
  Map<String, dynamic> toDBJson() {
    addEntries({'deleted': this['deleted'] ?? 0}.entries);
    return this;
  }
}

@JsonSerializable()
class Task extends Equatable {
  final String id;
  final String text;
  final Importance importance;
  @BoolOrIntToBoolConverter()
  @JsonKey(name: 'done')
  final bool isDone;
  @TimeStampOrNullConverter()
  final DateTime? deadline;
  final String? color;
  @TimeStampConverter()
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'changed_at')
  @TimeStampConverter()
  final DateTime changedAt;
  @JsonKey(name: 'last_updated_by')
  final String lastUpdatedBy;
  @BoolOrIntToBoolConverter()
  @JsonKey(includeToJson: false)
  final bool? deleted;

  Task(
      {required this.text,
      required this.createdAt,
      required this.changedAt,
      String? id,
      this.importance = Importance.none,
      this.isDone = false,
      this.deadline,
      this.color,
      this.lastUpdatedBy = 'example',
      this.deleted = false})
      : id = id ?? const Uuid().v4(),
        super();

  @override
  List<Object?> get props => [
        id,
        text,
        importance,
        isDone,
        deadline,
        color,
        createdAt,
        changedAt,
        lastUpdatedBy,
        deleted
      ];

  Task copyWith(
      {String? id,
      String? text,
      Importance? importance,
      bool? isDone,
      DateTime? deadline,
      bool? deleteDeadline,
      String? color,
      DateTime? createdAt,
      DateTime? changedAt,
      bool? deleted,
      String? lastUpdatedBy}) {
    return Task(
        id: id ?? this.id,
        text: text ?? this.text,
        importance: importance ?? this.importance,
        isDone: isDone ?? this.isDone,
        deadline: deleteDeadline ?? false ? null : deadline ?? this.deadline,
        color: color ?? this.color,
        createdAt: createdAt ?? this.createdAt,
        changedAt: changedAt ?? this.changedAt,
        deleted: deleted ?? this.deleted,
        lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy);
  }

  static Task fromJson(Map<String, dynamic> json) {
    return _$TaskFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  @override
  String toString() {
    return 'Task { id: $id, text: $text, importance: $importance, isDone: $isDone, deadline: $deadline, color: $color, createdAt: $createdAt, changedAt: $changedAt, lastUpdatedBy: $lastUpdatedBy }';
  }

  String toStringWithTypes() {
    return 'Task { id: $id ${id.runtimeType}, text: $text ${text.runtimeType}, importance: $importance ${importance.runtimeType}, isDone: $isDone ${isDone.runtimeType}, deadline: $deadline ${deadline.runtimeType}, color: $color ${color.runtimeType}, createdAt: $createdAt ${createdAt.runtimeType}, changedAt: $changedAt ${changedAt.runtimeType}, lastUpdatedBy: $lastUpdatedBy ${lastUpdatedBy.runtimeType}}';
  }
}

class TimeStampConverter implements JsonConverter<DateTime, int> {
  const TimeStampConverter();

  @override
  DateTime fromJson(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  @override
  int toJson(DateTime date) {
    return date.millisecondsSinceEpoch;
  }
}

class TimeStampOrNullConverter implements JsonConverter<DateTime?, int?> {
  const TimeStampOrNullConverter();

  @override
  DateTime? fromJson(int? timestamp) {
    return timestamp == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  @override
  int? toJson(DateTime? date) {
    return date?.millisecondsSinceEpoch;
  }
}

class BoolOrIntToBoolConverter implements JsonConverter<bool?, dynamic> {
  const BoolOrIntToBoolConverter();

  @override
  bool? fromJson(json) => json is int ? json == 1 : json;

  @override
  bool? toJson(bool? object) {
    return object;
  }
}
