import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list_app/core/presentation/styles/app_theme.dart';
import 'package:todo_list_app/core/utils/analytics_logger.dart';
import 'package:todo_list_app/features/tasks/presentation/bloc/tasks_bloc.dart';

class HomeScreenHeaderDelegate extends SliverPersistentHeaderDelegate {
  const HomeScreenHeaderDelegate();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final themeData = Theme.of(context);
    final text = themeData.textTheme;
    final diff = expandedHeight - kToolbarHeight;
    final k = (diff - shrinkOffset) / diff;
    final double percentOfShrinkOffset = max(k, 0);
    final colors = AppTheme.of(context).colors;

    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Material(
          color: themeData.scaffoldBackgroundColor,
          elevation: percentOfShrinkOffset <= 0.05
              ? 5 - 100 * percentOfShrinkOffset
              : 0,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: 16 + percentOfShrinkOffset * 10,
              right: 20 + percentOfShrinkOffset * 3,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 16 + 26 * percentOfShrinkOffset),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(width: 16 + 44 * percentOfShrinkOffset),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.appTitle,
                          style: text.titleLarge?.copyWith(
                            fontSize: max(
                                (text.titleLarge?.fontSize ?? 20) *
                                    percentOfShrinkOffset,
                                20),
                          ),
                        ),
                        if (percentOfShrinkOffset > 0)
                          Padding(
                            padding:
                                EdgeInsets.only(top: 6 * percentOfShrinkOffset),
                            child: Text(
                              AppLocalizations.of(context)!.tasksCompletedCount(
                                state.tasks
                                    .where((element) => element.isDone)
                                    .length,
                              ),
                              style: text.bodyMedium?.copyWith(
                                color: themeData.hintColor,
                                fontSize: (text.bodyMedium?.fontSize ?? 16) *
                                    percentOfShrinkOffset,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          state.completedVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 24,
                          color: colors.colorBlue,
                        ),
                        onPressed: () {
                          context
                              .read<TasksBloc>()
                              .add(const ToggleVisibilityCompletedFilter());
                          GetIt.I<AnalyticsLogger>().toggleVisibilityTasksFilter(
                              state.completedVisible);
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  double get expandedHeight => 200;

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
