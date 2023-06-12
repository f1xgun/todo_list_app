import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreenHeaderDelegate extends SliverPersistentHeaderDelegate {
  const HomeScreenHeaderDelegate();

  double get expandedHeight => 200;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final themeData = Theme.of(context);
    final text = themeData.textTheme;
    final diff = expandedHeight - kToolbarHeight;
    final t = (diff - shrinkOffset) / diff;
    // ignore: omit_local_variable_types
    final double percentOfShrinkOffset = t > 0 ? t : 0;

    return Material(
      color: themeData.scaffoldBackgroundColor,
      elevation:
          percentOfShrinkOffset <= 0.05 ? 5 - 100 * percentOfShrinkOffset : 0,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 16,
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
                        fontSize: 20 + 12 * percentOfShrinkOffset,
                      ),
                    ),
                    if (percentOfShrinkOffset > 0)
                      Padding(
                        padding:
                            EdgeInsets.only(top: 6 * percentOfShrinkOffset),
                        child: Text(
                          AppLocalizations.of(context)!.tasksCompletedCount(2),
                          style: text.bodyMedium?.copyWith(
                            color: themeData.hintColor,
                            fontSize: 16 * percentOfShrinkOffset,
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
                      Icons.visibility_off,
                      size: 24,
                      color: themeData.primaryColor,
                    ),
                    onPressed: null,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
