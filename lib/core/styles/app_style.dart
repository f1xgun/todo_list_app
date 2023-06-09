import 'package:flutter/material.dart';
import 'package:todo_list_app/core/styles/color_palette.dart';
import 'package:todo_list_app/core/styles/text_style.dart';

class AppStyle {
  final ColorPalette colorPalette;

  AppStyle(this.colorPalette);

  bool get _isDark => colorPalette.brightness == Brightness.dark;

  ThemeData get themeData => ThemeData(
        brightness: colorPalette.brightness,
        textTheme: appTextStyles.textTheme,
        scaffoldBackgroundColor: colorPalette.colorBackPrimary,
        dialogBackgroundColor: colorPalette.colorBackSecondary,
        hintColor: colorPalette.colorLabelTertiary,
        dividerColor: colorPalette.colorSupportSeparator,
        disabledColor: colorPalette.colorLabelDisable,
      );

  AppTextStyles get appTextStyles => AppTextStyles(colorPalette: colorPalette);
}
