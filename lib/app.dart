import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_list_app/core/navigation/route_information_parser.dart';
import 'package:todo_list_app/core/navigation/router_delegate.dart';
import 'package:todo_list_app/core/styles/app_style.dart';
import 'package:todo_list_app/core/styles/app_theme.dart';
import 'package:todo_list_app/core/styles/palettes/dark_palette.dart';
import 'package:todo_list_app/core/styles/palettes/light_palette.dart';
import 'package:todo_list_app/features/tasks/presentation/bloc/tasks_bloc.dart';

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final _routerDelegate = CustomRouterDelegate();
  final _routeInformationParser = CustomRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.platformBrightnessOf(context);
    final isDarkTheme = brightness == Brightness.dark;

    return AppTheme(
      colors: isDarkTheme ? darkPalette : lightPalette,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TasksBloc>(
            create: (context) => TasksBloc()..add(const LoadTasks()),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppStyle(isDarkTheme ? darkPalette : lightPalette).themeData,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
          routerDelegate: _routerDelegate,
          routeInformationParser: _routeInformationParser,
        ),
      ),
    );
  }
}
