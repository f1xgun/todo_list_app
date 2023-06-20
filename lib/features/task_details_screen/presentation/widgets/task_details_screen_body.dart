import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/features/task_details_screen/presentation/bloc/task_details_bloc.dart';
import 'package:todo_list_app/features/task_details_screen/presentation/widgets/task_details_deadline_field.dart';
import 'package:todo_list_app/features/task_details_screen/presentation/widgets/task_details_delete_button.dart';
import 'package:todo_list_app/features/task_details_screen/presentation/widgets/task_details_importance_field.dart';
import 'package:todo_list_app/features/task_details_screen/presentation/widgets/task_details_text_field.dart';

import 'package:todo_list_app/features/tasks/domain/enums/importance.dart';

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
            const Divider(
              indent: 16,
              endIndent: 16,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
              child: const TaskDetailsDeadlineField(),
            ),
            const Divider(),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TaskDetailsDeleteButton(isNew: isNew),
            ),
          ],
        );
      },
    );
  }
}
