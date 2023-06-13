import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_list_app/core/styles/theme/bloc/theme_bloc.dart';
import 'package:todo_list_app/features/task_details_screen/presentation/bloc/task_details_bloc.dart';
import 'package:todo_list_app/features/task_details_screen/presentation/widgets/task_details_importance_field.dart';
import 'package:todo_list_app/features/task_details_screen/presentation/widgets/task_details_text_field.dart';

import 'package:todo_list_app/features/tasks/domain/enums/importance.dart';

import 'package:todo_list_app/features/tasks/presentation/bloc/tasks_bloc.dart';

class TaskDetailsScreenBody extends StatefulWidget {
  const TaskDetailsScreenBody({required this.controller, super.key});
  final TextEditingController controller;

  @override
  State<TaskDetailsScreenBody> createState() => _TaskDetailsScreenBodyState();
}

class _TaskDetailsScreenBodyState extends State<TaskDetailsScreenBody> {
  late Bloc<TaskDetailsEvent, TaskDetailsState> taskBloc;

  @override
  void initState() {
    taskBloc = context.read<TaskDetailsBloc>();
    widget.controller.value =
        TextEditingValue(text: taskBloc.state.currentTask.text);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void updateImportance(Importance importance) {
    taskBloc.add(TaskDetailsUpdateImportance(importance: importance));
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final isNew = arguments['isNew'];
    final colors = context.read<ThemeBloc>().state.colorPalette;
    return BlocBuilder<TaskDetailsBloc, TaskDetailsState>(
      builder: (context, state) {
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TaskDetailsTextField(controller: widget.controller),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: TaskDetailsImportanceField(
                selectedImportance: state.currentTask.importance,
                onImportanceValueChanged: updateImportance,
              ),
            ),
            Divider(
              indent: 16,
              endIndent: 16,
              color: colors.colorSupportSeparator,
              thickness: 1,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context)!.deadlineTitle),
                    ],
                  ),
                  const Spacer(),
                  const Switch.adaptive(value: true, onChanged: null),
                ],
              ),
            ),
            Divider(
              color: colors.colorSupportSeparator,
              thickness: 1,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor:
                      isNew ? colors.colorLabelDisable : colors.colorRed,
                ),
                onPressed: isNew
                    ? null
                    : () {
                        context
                            .read<TasksBloc>()
                            .add(DeleteTask(task: taskBloc.state.currentTask));
                        Navigator.pop(context);
                      },
                icon: const Icon(Icons.delete),
                label: Text(AppLocalizations.of(context)!.delete),
              ),
            ),
          ],
        );
      },
    );
  }
}
