import 'package:flutter/material.dart';
import 'package:todo_list_app/core/presentation/styles/color_palette.dart';

class AppTheme extends InheritedWidget {
  final ColorPalette colors;
  const AppTheme({required this.colors, required super.child, super.key});

  @override
  bool updateShouldNotify(AppTheme oldWidget) => colors != oldWidget.colors;

  static AppTheme of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<AppTheme>();

    if (theme == null) {
      throw Exception('No AppTheme in widget tree. Wrap tree in AppTheme');
    }

    return theme;
  }
}
