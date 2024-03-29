import 'package:flutter/material.dart';
import 'package:todo_list_app/core/presentation/styles/color_palette.dart';
import 'package:todo_list_app/core/presentation/styles/text_style.dart';

class AppStyle {
  final ColorPalette colorPalette;
  final double shortestSide;

  AppStyle(this.colorPalette, this.shortestSide);

  ThemeData get themeData => ThemeData(
        brightness: colorPalette.brightness,
        textTheme: appTextStyles.textTheme,
        scaffoldBackgroundColor: colorPalette.colorBackPrimary,
        dialogBackgroundColor: colorPalette.colorBackSecondary,
        hintColor: colorPalette.colorLabelTertiary,
        dividerColor: colorPalette.colorSupportSeparator,
        disabledColor: colorPalette.colorLabelDisable,
      );

  AppTextStyles get appTextStyles =>
      AppTextStyles(colorPalette: colorPalette, shortestSide: shortestSide);
}
