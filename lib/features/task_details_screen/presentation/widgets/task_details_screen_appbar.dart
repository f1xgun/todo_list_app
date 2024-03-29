import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list_app/core/data/managers/navigation_manager.dart';
import 'package:todo_list_app/core/presentation/styles/app_theme.dart';
import 'package:todo_list_app/core/utils/logger.dart';

class TaskDetailsScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const TaskDetailsScreenAppBar({required this.saveTask, super.key});

  final void Function(BuildContext) saveTask;

  @override
  Widget build(BuildContext context) {
    final tempData = Theme.of(context);
    final text = tempData.textTheme;
    final colors = AppTheme.of(context).colors;
    return AppBar(
      backgroundColor: colors.colorBackPrimary,
      scrolledUnderElevation: 4,
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
          child: SizedBox(
            child: TextButton(
              key: const ValueKey('saveTaskButton'),
              onPressed: () {
                saveTask(context);
                GetIt.I<NavigationManager>().pop(context);
                logger.info('Close task details screen with saving task');
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8),
              ),
              child: Text(
                AppLocalizations.of(context)!.save.toUpperCase(),
                style: text.labelMedium!.copyWith(
                  color: colors.colorBlue,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
