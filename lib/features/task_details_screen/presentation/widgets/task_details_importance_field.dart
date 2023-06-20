import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_list_app/core/styles/theme/bloc/theme_bloc.dart';
import 'package:todo_list_app/features/tasks/domain/enums/importance.dart';

class TaskDetailsImportanceField extends StatelessWidget {
  const TaskDetailsImportanceField({
    required this.selectedImportance,
    required this.onImportanceValueChanged,
    super.key,
  });

  final Importance selectedImportance;
  final void Function(Importance importance) onImportanceValueChanged;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return PopupMenuButton<Importance>(
      initialValue: selectedImportance,
      itemBuilder: (context) => <PopupMenuEntry<Importance>>[
        for (var importance in Importance.values)
          PopupMenuItem<Importance>(
            value: importance,
            child: PopupImportanceItem(importance: importance),
          ),
      ],
      onSelected: onImportanceValueChanged,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.importance,
            style: text.bodyMedium,
          ),
          ImportanceText(importance: selectedImportance)
        ],
      ),
    );
  }
}

class ImportanceText extends StatelessWidget {
  const ImportanceText({required this.importance, super.key});

  final Importance importance;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final colors = context.read<ThemeBloc>().state.colorPalette;
    return switch (importance) {
      Importance.none => Text(
          AppLocalizations.of(context)!.importanceNo,
          style: text.titleSmall?.copyWith(
            color: colors.colorLabelTertiary,
          ),
        ),
      Importance.lowPriority => Text(
          AppLocalizations.of(context)!.importanceLowPriority,
          style: text.titleSmall,
        ),
      Importance.highPriority => Text(
          AppLocalizations.of(context)!.importanceHighPriority,
          style: text.titleSmall?.copyWith(
            color: colors.colorRed,
          ),
        )
    };
  }
}

class PopupImportanceItem extends StatelessWidget {
  const PopupImportanceItem({required this.importance, super.key});

  final Importance importance;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final colors = context.read<ThemeBloc>().state.colorPalette;
    return switch (importance) {
      Importance.none => Text(
          AppLocalizations.of(context)!.importanceNo,
          style: text.bodyMedium,
        ),
      Importance.lowPriority => Text(
          AppLocalizations.of(context)!.importanceLowPriority,
          style: text.bodyMedium,
        ),
      Importance.highPriority => Text(
          AppLocalizations.of(context)!.importanceHighPriority,
          style: text.bodyMedium?.copyWith(
            color: colors.colorRed,
          ),
        )
    };
  }
}
