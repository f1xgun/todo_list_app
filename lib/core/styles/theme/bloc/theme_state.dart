part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final bool isDarkTheme;
  final ColorPalette colorPalette;

  const ThemeState({required this.isDarkTheme, required this.colorPalette});

  @override
  List<Object> get props => [isDarkTheme, colorPalette];
}

class ThemeInitial extends ThemeState {
  const ThemeInitial({required super.isDarkTheme, required super.colorPalette});
}
