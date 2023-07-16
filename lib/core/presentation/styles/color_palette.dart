import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list_app/core/config/firebase_config_repository.dart';
import 'package:todo_list_app/core/domain/converters/hex_color_converter.dart';

class ColorPalette {
  ColorPalette.light({
    required this.colorSupportSeparator,
    required this.colorSupportOverlay,
    required this.colorLabelPrimary,
    required this.colorLabelSecondary,
    required this.colorLabelTertiary,
    required this.colorLabelDisable,
    required this.colorRed,
    required this.colorGreen,
    required this.colorBlue,
    required this.colorGray,
    required this.colorGrayLight,
    required this.colorWhite,
    required this.colorBackPrimary,
    required this.colorBackSecondary,
    required this.colorBackElevated,
  })  : brightness = Brightness.light,
        colorImportantTask = getColorFromHex(GetIt.I<FirebaseConfigRepository>()
            .importantTaskColorNotifier
            .value);

  ColorPalette.dark({
    required this.colorSupportSeparator,
    required this.colorSupportOverlay,
    required this.colorLabelPrimary,
    required this.colorLabelSecondary,
    required this.colorLabelTertiary,
    required this.colorLabelDisable,
    required this.colorRed,
    required this.colorGreen,
    required this.colorBlue,
    required this.colorGray,
    required this.colorGrayLight,
    required this.colorWhite,
    required this.colorBackPrimary,
    required this.colorBackSecondary,
    required this.colorBackElevated,
  })  : brightness = Brightness.dark,
        colorImportantTask = getColorFromHex(GetIt.I<FirebaseConfigRepository>()
            .importantTaskColorNotifier
            .value);

  final Brightness brightness;

  final Color colorSupportSeparator;
  final Color colorSupportOverlay;

  final Color colorLabelPrimary;
  final Color colorLabelSecondary;
  final Color colorLabelTertiary;
  final Color colorLabelDisable;

  final Color colorRed;
  final Color colorGreen;
  final Color colorBlue;
  final Color colorGray;
  final Color colorGrayLight;
  final Color colorWhite;

  final Color colorBackPrimary;
  final Color colorBackSecondary;
  final Color colorBackElevated;

  Color colorImportantTask;
}
