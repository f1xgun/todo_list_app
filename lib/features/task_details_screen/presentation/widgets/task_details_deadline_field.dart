import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/core/presentation/styles/app_theme.dart';
import 'package:todo_list_app/features/task_details_screen/presentation/bloc/task_details_bloc.dart';
import 'package:todo_list_app/features/task_details_screen/presentation/widgets/task_details_deadline_text.dart';

class TaskDetailsDeadlineField extends StatefulWidget {
  const TaskDetailsDeadlineField({super.key});

  @override
  State<TaskDetailsDeadlineField> createState() =>
      _TaskDetailsDeadlineFieldState();
}

class _TaskDetailsDeadlineFieldState extends State<TaskDetailsDeadlineField> {
  bool switchValue = false;

  Future<void> pickDate(BuildContext context, DateTime? deadline) async {
    await showDatePicker(
      context: context,
      initialDate: deadline ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    ).then((date) {
      if (date != null) {
        context
            .read<TaskDetailsBloc>()
            .add(TaskDetailsUpdateDeadline(deadline: date));
        setState(() {
          switchValue = true;
        });
      }
    });
  }

  void clearDate(BuildContext context) {
    context.read<TaskDetailsBloc>().add(const TaskDetailsDeleteDeadline());
    setState(() {
      switchValue = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context).colors;
    return BlocBuilder<TaskDetailsBloc, TaskDetailsState>(
      builder: (context, state) {
        switchValue = state.currentTask.deadline != null;
        return Row(
          children: [
            GestureDetector(
              onTap: () => pickDate(context, state.currentTask.deadline),
              child: const SizedBox(
                height: 40,
                child: TaskDetailsDeadlineText(),
              ),
            ),
            const Spacer(),
            Switch.adaptive(
              activeColor: colors.colorBlue,
              value: switchValue,
              onChanged: (value) {
                if (value) {
                  pickDate(context, state.currentTask.deadline);
                } else {
                  clearDate(context);
                }
              },
            )
          ],
        );
      },
    );
  }
}
