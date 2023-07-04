// Mocks generated by Mockito 5.4.2 from annotations
// in todo_list_app/test/test_doubles/persistence_manager_mock.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:todo_list_app/core/managers/persistence_manager.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [PersistenceManager].
///
/// See the documentation for Mockito's code generation for more information.
class MockPersistenceManager extends _i1.Mock
    implements _i2.PersistenceManager {
  MockPersistenceManager() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<int?> getTasksRevision() => (super.noSuchMethod(
        Invocation.method(
          #getTasksRevision,
          [],
        ),
        returnValue: _i3.Future<int?>.value(),
      ) as _i3.Future<int?>);
  @override
  _i3.Future<void> saveTasksRevision({required int? revision}) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveTasksRevision,
          [],
          {#revision: revision},
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<String?> getDeviceId() => (super.noSuchMethod(
        Invocation.method(
          #getDeviceId,
          [],
        ),
        returnValue: _i3.Future<String?>.value(),
      ) as _i3.Future<String?>);
  @override
  _i3.Future<void> generateAndSaveDeviceId() => (super.noSuchMethod(
        Invocation.method(
          #generateAndSaveDeviceId,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}
