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
  final bool isDone;
  final bool isDeleted;
  final String? deadline;
  final String? lastUpdated;

  Task(
      {required this.text,
      String? id,
      this.importance = Importance.None,
      this.isDone = false,
      this.isDeleted = false,
      this.deadline = '',
      this.lastUpdated = ''})
      : id = id ?? const Uuid().v4(),
        super();

  @override
  List<Object?> get props =>
      [id, text, importance, isDone, isDeleted, deadline, lastUpdated];

  static Task fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
