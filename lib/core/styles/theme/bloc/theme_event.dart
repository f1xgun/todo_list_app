part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {
  const ThemeEvent();
}

class ToggleThemeEvent extends ThemeEvent {
  final Brightness brightness;

  const ToggleThemeEvent({required this.brightness});
}
