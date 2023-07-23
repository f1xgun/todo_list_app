import 'package:flutter/material.dart';
import 'package:todo_list_app/core/presentation/styles/color_palette.dart';

class AppTextStyles {
  final ColorPalette colorPalette;
  final double shortestSide;
  AppTextStyles({required this.shortestSide, required this.colorPalette})
      : kFontSize = shortestSide > 500 ? 1.3 : 1;
  double kFontSize;

  TextStyle get font {
    return const TextStyle(fontFamily: 'Roboto')
        .copyWith(color: colorPalette.colorLabelPrimary);
  }

  TextStyle get largeTitle => font.copyWith(
      fontSize: 32 * kFontSize, height: 38 / 32, fontWeight: FontWeight.w500);

  TextStyle get title => font.copyWith(
      fontSize: 20 * kFontSize, height: 32 / 20, fontWeight: FontWeight.w500);

  TextStyle get button => font.copyWith(
      fontSize: 14 * kFontSize, height: 24 / 14, fontWeight: FontWeight.w500);

  TextStyle get body => font.copyWith(
      fontSize: 16 * kFontSize, height: 20 / 16, fontWeight: FontWeight.w400);

  TextStyle get subhead => font.copyWith(
      fontSize: 14 * kFontSize, height: 20 / 14, fontWeight: FontWeight.w400);

  TextTheme get textTheme => TextTheme(
        titleLarge: largeTitle,
        titleMedium: title,
        labelMedium: button,
        bodyMedium: body,
        titleSmall: subhead,
      );
}
