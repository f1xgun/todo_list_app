import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:todo_list_app/features/tasks/domain/enums/importance.dart';
import 'package:uuid/uuid.dart';

part 'task_model.g.dart';

@JsonSerializable()
class Task extends Equatable {
  final String id;
  final String text;
  final Importance importance;
  @JsonKey(name: 'done')
  final bool isDone;
  final DateTime? deadline;
  final String? color;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'changed_at')
  final DateTime? changedAt;
  @JsonKey(name: 'last_updated_by')
  final String? lastUpdatedBy;

  Task({
    required this.text,
    String? id,
    this.importance = Importance.none,
    this.isDone = false,
    this.deadline,
    this.color,
    this.createdAt,
    this.changedAt,
    this.lastUpdatedBy,
  })  : id = id ?? const Uuid().v4(),
        super();

  @override
  List<Object?> get props => [id, text, importance, isDone, deadline, color, createdAt, changedAt, lastUpdatedBy];

  Task copyWith({
    String? id,
    String? text,
    Importance? importance,
    bool? isDone,
    DateTime? deadline,
    bool? deleteDeadline,
  }) {
    return Task(
      id: id ?? this.id,
      text: text ?? this.text,
      importance: importance ?? this.importance,
      isDone: isDone ?? this.isDone,
      deadline: deleteDeadline ?? false ? null : deadline ?? this.deadline,
    );
  }

  static Task fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
