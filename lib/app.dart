import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_list_app/core/constants/app_route_constants.dart';
import 'package:todo_list_app/core/styles/app_style.dart';
import 'package:todo_list_app/core/styles/app_theme.dart';
import 'package:todo_list_app/core/styles/palettes/dark_palette.dart';
import 'package:todo_list_app/core/styles/palettes/light_palette.dart';
import 'package:todo_list_app/features/home/presentation/home_screen.dart';
import 'package:todo_list_app/features/task_details_screen/presentation/task_details_screen.dart';
import 'package:todo_list_app/features/tasks/presentation/bloc/tasks_bloc.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppStyle(isDarkTheme ? darkPalette : lightPalette).themeData,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
          initialRoute: AppRoutes.homeRoute,
          routes: <String, WidgetBuilder>{
            AppRoutes.homeRoute: (context) => const HomeScreen(),
            AppRoutes.taskDetailRoute: (context) => const TaskDetailsScreen()
          },
        ),
      ),
    );
  }
}
