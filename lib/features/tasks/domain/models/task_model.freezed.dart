// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Task _$TaskFromJson(Map<String, dynamic> json) {
  return _Task.fromJson(json);
}

/// @nodoc
mixin _$Task {
  String get text => throw _privateConstructorUsedError;
  @TimeStampConverter()
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'changed_at')
  @TimeStampConverter()
  DateTime get changedAt => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  Importance get importance => throw _privateConstructorUsedError;
  @BoolOrIntToBoolConverter()
  @JsonKey(name: 'done')
  bool get isDone => throw _privateConstructorUsedError;
  @TimeStampOrNullConverter()
  DateTime? get deadline => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_updated_by')
  String get lastUpdatedBy => throw _privateConstructorUsedError;
  @NullOrIntToBoolConverter()
  @JsonKey(includeToJson: false)
  bool? get deleted => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskCopyWith<Task> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskCopyWith<$Res> {
  factory $TaskCopyWith(Task value, $Res Function(Task) then) =
      _$TaskCopyWithImpl<$Res, Task>;
  @useResult
  $Res call(
      {String text,
      @TimeStampConverter() @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'changed_at') @TimeStampConverter() DateTime changedAt,
      String id,
      Importance importance,
      @BoolOrIntToBoolConverter() @JsonKey(name: 'done') bool isDone,
      @TimeStampOrNullConverter() DateTime? deadline,
      String? color,
      @JsonKey(name: 'last_updated_by') String lastUpdatedBy,
      @NullOrIntToBoolConverter()
      @JsonKey(includeToJson: false)
      bool? deleted});
}

/// @nodoc
class _$TaskCopyWithImpl<$Res, $Val extends Task>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? createdAt = null,
    Object? changedAt = null,
    Object? id = null,
    Object? importance = null,
    Object? isDone = null,
    Object? deadline = freezed,
    Object? color = freezed,
    Object? lastUpdatedBy = null,
    Object? deleted = freezed,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      changedAt: null == changedAt
          ? _value.changedAt
          : changedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      importance: null == importance
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as Importance,
      isDone: null == isDone
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      lastUpdatedBy: null == lastUpdatedBy
          ? _value.lastUpdatedBy
          : lastUpdatedBy // ignore: cast_nullable_to_non_nullable
              as String,
      deleted: freezed == deleted
          ? _value.deleted
          : deleted // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TaskCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$$_TaskCopyWith(_$_Task value, $Res Function(_$_Task) then) =
      __$$_TaskCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String text,
      @TimeStampConverter() @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'changed_at') @TimeStampConverter() DateTime changedAt,
      String id,
      Importance importance,
      @BoolOrIntToBoolConverter() @JsonKey(name: 'done') bool isDone,
      @TimeStampOrNullConverter() DateTime? deadline,
      String? color,
      @JsonKey(name: 'last_updated_by') String lastUpdatedBy,
      @NullOrIntToBoolConverter()
      @JsonKey(includeToJson: false)
      bool? deleted});
}

/// @nodoc
class __$$_TaskCopyWithImpl<$Res> extends _$TaskCopyWithImpl<$Res, _$_Task>
    implements _$$_TaskCopyWith<$Res> {
  __$$_TaskCopyWithImpl(_$_Task _value, $Res Function(_$_Task) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? createdAt = null,
    Object? changedAt = null,
    Object? id = null,
    Object? importance = null,
    Object? isDone = null,
    Object? deadline = freezed,
    Object? color = freezed,
    Object? lastUpdatedBy = null,
    Object? deleted = freezed,
  }) {
    return _then(_$_Task(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      changedAt: null == changedAt
          ? _value.changedAt
          : changedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      importance: null == importance
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as Importance,
      isDone: null == isDone
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      lastUpdatedBy: null == lastUpdatedBy
          ? _value.lastUpdatedBy
          : lastUpdatedBy // ignore: cast_nullable_to_non_nullable
              as String,
      deleted: freezed == deleted
          ? _value.deleted
          : deleted // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Task implements _Task {
  const _$_Task(
      {required this.text,
      @TimeStampConverter()
      @JsonKey(name: 'created_at')
      required this.createdAt,
      @JsonKey(name: 'changed_at')
      @TimeStampConverter()
      required this.changedAt,
      this.id = '',
      this.importance = Importance.none,
      @BoolOrIntToBoolConverter() @JsonKey(name: 'done') this.isDone = false,
      @TimeStampOrNullConverter() this.deadline,
      this.color,
      @JsonKey(name: 'last_updated_by') this.lastUpdatedBy = 'example',
      @NullOrIntToBoolConverter()
      @JsonKey(includeToJson: false)
      this.deleted = false});

  factory _$_Task.fromJson(Map<String, dynamic> json) => _$$_TaskFromJson(json);

  @override
  final String text;
  @override
  @TimeStampConverter()
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'changed_at')
  @TimeStampConverter()
  final DateTime changedAt;
  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final Importance importance;
  @override
  @BoolOrIntToBoolConverter()
  @JsonKey(name: 'done')
  final bool isDone;
  @override
  @TimeStampOrNullConverter()
  final DateTime? deadline;
  @override
  final String? color;
  @override
  @JsonKey(name: 'last_updated_by')
  final String lastUpdatedBy;
  @override
  @NullOrIntToBoolConverter()
  @JsonKey(includeToJson: false)
  final bool? deleted;

  @override
  String toString() {
    return 'Task(text: $text, createdAt: $createdAt, changedAt: $changedAt, id: $id, importance: $importance, isDone: $isDone, deadline: $deadline, color: $color, lastUpdatedBy: $lastUpdatedBy, deleted: $deleted)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Task &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.changedAt, changedAt) ||
                other.changedAt == changedAt) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.importance, importance) ||
                other.importance == importance) &&
            (identical(other.isDone, isDone) || other.isDone == isDone) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.lastUpdatedBy, lastUpdatedBy) ||
                other.lastUpdatedBy == lastUpdatedBy) &&
            (identical(other.deleted, deleted) || other.deleted == deleted));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, text, createdAt, changedAt, id,
      importance, isDone, deadline, color, lastUpdatedBy, deleted);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TaskCopyWith<_$_Task> get copyWith =>
      __$$_TaskCopyWithImpl<_$_Task>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TaskToJson(
      this,
    );
  }
}

abstract class _Task implements Task {
  const factory _Task(
      {required final String text,
      @TimeStampConverter()
      @JsonKey(name: 'created_at')
      required final DateTime createdAt,
      @JsonKey(name: 'changed_at')
      @TimeStampConverter()
      required final DateTime changedAt,
      final String id,
      final Importance importance,
      @BoolOrIntToBoolConverter() @JsonKey(name: 'done') final bool isDone,
      @TimeStampOrNullConverter() final DateTime? deadline,
      final String? color,
      @JsonKey(name: 'last_updated_by') final String lastUpdatedBy,
      @NullOrIntToBoolConverter()
      @JsonKey(includeToJson: false)
      final bool? deleted}) = _$_Task;

  factory _Task.fromJson(Map<String, dynamic> json) = _$_Task.fromJson;

  @override
  String get text;
  @override
  @TimeStampConverter()
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'changed_at')
  @TimeStampConverter()
  DateTime get changedAt;
  @override
  String get id;
  @override
  Importance get importance;
  @override
  @BoolOrIntToBoolConverter()
  @JsonKey(name: 'done')
  bool get isDone;
  @override
  @TimeStampOrNullConverter()
  DateTime? get deadline;
  @override
  String? get color;
  @override
  @JsonKey(name: 'last_updated_by')
  String get lastUpdatedBy;
  @override
  @NullOrIntToBoolConverter()
  @JsonKey(includeToJson: false)
  bool? get deleted;
  @override
  @JsonKey(ignore: true)
  _$$_TaskCopyWith<_$_Task> get copyWith => throw _privateConstructorUsedError;
}
