import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_list_app/core/styles/app_theme.dart';
import 'package:todo_list_app/features/tasks/domain/models/task_model.dart';
import 'package:todo_list_app/features/tasks/presentation/bloc/tasks_bloc.dart';

class HomeScreenNewTaskField extends StatefulWidget {
  const HomeScreenNewTaskField({super.key});

  @override
  State<HomeScreenNewTaskField> createState() => _HomeScreenNewTaskFieldState();
}

class _HomeScreenNewTaskFieldState extends State<HomeScreenNewTaskField> {
  TextEditingController controller = TextEditingController();

  void addNewTask(BuildContext context) {
    context.read<TasksBloc>().add(AddTask(
        task: Task(
            text: controller.text,
            createdAt: DateTime.now(),
            changedAt: DateTime.now())));
    controller.text = '';
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final text = themeData.textTheme;
    final colors = AppTheme.of(context).colors;
    return TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: AppLocalizations.of(context)!.addNewTaskText,
        hintStyle: text.bodyMedium?.copyWith(color: colors.colorLabelTertiary),
      ),
      style: text.bodyMedium,
      controller: controller,
      onSubmitted: (value) => addNewTask(context),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
