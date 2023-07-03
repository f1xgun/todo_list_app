import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_list_app/core/styles/theme/bloc/theme_bloc.dart';
import 'package:todo_list_app/features/tasks/domain/enums/importance.dart';

class TaskCardViewImportanceIcon extends StatelessWidget {
  const TaskCardViewImportanceIcon({
    required this.importance,
    super.key,
  });

  final Importance importance;

  @override
  Widget build(BuildContext context) {
    final colors = context.read<ThemeBloc>().state.colorPalette;

    return switch (importance) {
      Importance.lowPriority => SvgPicture.asset(
          'assets/low_priority_importance.svg',
          colorFilter: ColorFilter.mode(
            colors.colorLabelTertiary,
            BlendMode.srcIn,
          ),
        ),
      Importance.highPriority => SvgPicture.asset(
          'assets/high_priority_importance.svg',
          colorFilter: ColorFilter.mode(
            colors.colorRed,
            BlendMode.srcIn,
          ),
        ),
      _ => const SizedBox.shrink(),
    };
  }
}
