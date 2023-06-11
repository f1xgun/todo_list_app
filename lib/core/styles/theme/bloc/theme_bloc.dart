import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState(isDarkTheme: ThemeMode.system == ThemeMode.dark)) {
    on<ToggleThemeEvent>((event, emit) {
      emit(ThemeState(isDarkTheme: !state.isDarkTheme));
    });
  }
}
