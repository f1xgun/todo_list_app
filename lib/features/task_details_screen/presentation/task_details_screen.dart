import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/core/utils/logger.dart';
import 'package:todo_list_app/features/task_details_screen/presentation/bloc/task_details_bloc.dart';
import 'package:todo_list_app/features/task_details_screen/presentation/widgets/task_details_screen_appbar.dart';
import 'package:todo_list_app/features/task_details_screen/presentation/widgets/task_details_screen_body.dart';
import 'package:todo_list_app/features/tasks/domain/models/task_model.dart';
import 'package:todo_list_app/features/tasks/presentation/bloc/tasks_bloc.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen(
      {required this.taskId, required this.isNewTask, super.key});

  final String taskId;
  final bool isNewTask;

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void saveTask(BuildContext context) {
    final taskDetailBloc = context.read<TaskDetailsBloc>();
    if (taskDetailBloc.state.isNewTask) {
      context.read<TasksBloc>().add(AddTask(
          task: taskDetailBloc.state.currentTask
              .copyWith(text: controller.text)));
    } else {
      context.read<TasksBloc>().add(UpdateTask(
          task: taskDetailBloc.state.currentTask
              .copyWith(text: controller.text, changedAt: DateTime.now())));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isNewTask) {
      logger.info('Open task details page to create new task');
    } else {
      logger.info('Open task details page to edit task');
    }

    var isNewTask = widget.isNewTask;

    final task = context
        .read<TasksBloc>()
        .state
        .tasks
        .firstWhere((task) => task.id == widget.taskId, orElse: () {
      isNewTask = true;
      return Task(
          text: '', createdAt: DateTime.now(), changedAt: DateTime.now());
    });

    return BlocProvider(
      create: (context) =>
          TaskDetailsBloc(currentTask: task, isNewTask: isNewTask),
      child: BlocBuilder<TaskDetailsBloc, TaskDetailsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: TaskDetailsScreenAppBar(saveTask: saveTask),
            body: TaskDetailsScreenBody(
              controller: controller,
            ),
          );
        },
      ),
    );
  }
}
