import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/core/utils/logger.dart';
import 'package:todo_list_app/features/task_details_screen/presentation/widgets/task_details_importance_field.dart';
import 'package:todo_list_app/features/tasks/domain/api/local_tasks_api.dart';
import 'package:todo_list_app/features/tasks/domain/api/network_tasks_api.dart';
import 'package:todo_list_app/features/tasks/domain/enums/importance.dart';
import 'package:todo_list_app/features/tasks/presentation/task_card.dart';
import 'test_main.dart' as test_main;

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    logger.info('Start create task integration test');
  });

  testWidgets('Create new task', (widgetTester) async {
    test_main.main();
    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.byTooltip('Add new task'));
    await widgetTester.pumpAndSettle();

    await widgetTester.enterText(find.byType(TextField).first, 'New task');
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.byType(TaskDetailsImportanceField));
    await widgetTester.pumpAndSettle();
    expect(find.byType(PopupMenuItem<Importance>), findsWidgets);

    await widgetTester.tap(find.text('!! Высокий'));
    await widgetTester.pumpAndSettle();
    expect(find.text('!! Высокий'), findsOneWidget);

    await widgetTester.tap(find.byType(Switch));
    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.widgetWithText(TextButton, 'ОК'));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.byKey(const ValueKey('saveTaskButton')));
    await widgetTester.pumpAndSettle();
    expect(find.text('Список дел'), findsOneWidget);
    expect(find.byType(TaskCard), findsOneWidget);
    expect(find.textContaining('New task', findRichText: true), findsOneWidget);
    expect(find.text(DateFormat.yMMMMd('ru-RU').format(DateTime.now())),
        findsOneWidget);

    expect((await GetIt.I<LocalTasksApi>().getTasks())[0].text, 'New task');
    expect((await GetIt.I<LocalTasksApi>().getTasks())[0].importance,
        Importance.highPriority);

    expect((await GetIt.I<NetworkTasksApi>().getTasks()).data?[0].text,
        'New task');
    expect((await GetIt.I<NetworkTasksApi>().getTasks()).data?[0].importance,
        Importance.highPriority);
  });
}
