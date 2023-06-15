import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/core/styles/color_palette.dart';
import 'package:todo_list_app/core/styles/palettes/dark_palette.dart';
import 'package:todo_list_app/core/styles/palettes/light_palette.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({required bool isDark})
      : super(ThemeInitial(
          isDarkTheme: isDark,
          colorPalette: isDark ? darkPalette : lightPalette,
        )) {
    on<ToggleThemeEvent>(_onToggleThemeEvent);
  }

  Future<void> _onToggleThemeEvent(
      ToggleThemeEvent event, Emitter<ThemeState> emit) async {
    emit(ThemeState(
      isDarkTheme: event.brightness == Brightness.dark,
      colorPalette:
          event.brightness == Brightness.dark ? darkPalette : lightPalette,
    ));
  }
}
