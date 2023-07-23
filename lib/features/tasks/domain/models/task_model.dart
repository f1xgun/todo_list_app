import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_list_app/features/tasks/domain/enums/importance.dart';
import 'package:uuid/uuid.dart';

part 'task_model.g.dart';
part 'task_model.freezed.dart';

extension TaskMapExtension on Map<String, dynamic> {
  Map<String, dynamic> toDBJson() {
    addEntries({'deleted': this['deleted'] ?? 0}.entries);
    return this;
  }
}

@freezed
class Task with _$Task {
  const factory Task({
    required String text,
    @TimeStampConverter()
    @JsonKey(name: 'created_at')
    required DateTime createdAt,
    @JsonKey(name: 'changed_at')
    @TimeStampConverter()
    required DateTime changedAt,
    @Default('') String id,
    @Default(Importance.none) Importance importance,
    @BoolOrIntToBoolConverter()
    @JsonKey(name: 'done')
    @Default(false)
    bool isDone,
    @TimeStampOrNullConverter() DateTime? deadline,
    String? color,
    @JsonKey(name: 'last_updated_by') @Default('example') String lastUpdatedBy,
    @Default(false)
    @NullOrIntToBoolConverter()
    @JsonKey(includeToJson: false)
    bool? deleted,
  }) = _Task;

  factory Task.withDefaultId({
    required String text,
    required DateTime createdAt,
    required DateTime changedAt,
    Importance importance = Importance.none,
    bool isDone = false,
    DateTime? deadline,
    String? color,
    String lastUpdatedBy = 'example',
    bool? deleted,
  }) =>
      Task(
        text: text,
        importance: importance,
        isDone: isDone,
        deadline: deadline,
        color: color,
        createdAt: createdAt,
        changedAt: changedAt,
        lastUpdatedBy: lastUpdatedBy,
        deleted: deleted,
      ).copyWith(id: const Uuid().v4());

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}

class TimeStampConverter implements JsonConverter<DateTime, int> {
  const TimeStampConverter();

  @override
  DateTime fromJson(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }

  @override
  int toJson(DateTime date) {
    return date.millisecondsSinceEpoch ~/ 1000;
  }
}

class TimeStampOrNullConverter implements JsonConverter<DateTime?, int?> {
  const TimeStampOrNullConverter();

  @override
  DateTime? fromJson(int? timestamp) {
    return timestamp == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }

  @override
  int? toJson(DateTime? date) {
    return date == null ? null : date.millisecondsSinceEpoch ~/ 1000;
  }
}

class BoolOrIntToBoolConverter implements JsonConverter<bool, dynamic> {
  const BoolOrIntToBoolConverter();

  @override
  bool fromJson(json) => json is int ? json == 1 : json;

  @override
  bool toJson(bool object) => object;
}

class NullOrIntToBoolConverter implements JsonConverter<bool, int?> {
  const NullOrIntToBoolConverter();

  @override
  bool fromJson(int? json) => json is int && json == 1;

  @override
  int toJson(bool object) => object ? 1 : 0;
}
