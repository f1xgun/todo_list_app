import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_list_app/core/presentation/styles/app_theme.dart';

class TaskDetailsTextField extends StatelessWidget {
  const TaskDetailsTextField({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context).colors;
    final theme = Theme.of(context);
    final text = theme.textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.colorBackSecondary,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.2),
            offset: const Offset(2, 0),
            blurRadius: 2,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        style: text.bodyMedium,
        minLines: 3,
        maxLines: null,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: AppLocalizations.of(context)!.addNewTaskHintText,
          hintStyle: text.bodyMedium?.copyWith(
            color: colors.colorLabelTertiary,
          ),
        ),
      ),
    );
  }
}
