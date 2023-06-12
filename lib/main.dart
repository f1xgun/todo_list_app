import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:todo_list_app/core/styles/app_style.dart';
import 'package:todo_list_app/core/styles/palettes/dark_palette.dart';
import 'package:todo_list_app/core/styles/palettes/light_palette.dart';
import 'package:todo_list_app/core/styles/theme/bloc/theme_bloc.dart';
import 'package:todo_list_app/core/utils/error_handler.dart';
import 'package:todo_list_app/core/utils/logger.dart';
import 'package:todo_list_app/features/home/presentation/home_screen.dart';
import 'package:todo_list_app/features/tasks/presentation/bloc/tasks_bloc.dart';

void main() {
  runZonedGuarded(() {
    initLogger();
    logger.info('Start main');

    ErrorHandler.init();
    runApp(
      const MainApp(),
    );
  }, ErrorHandler.recordError);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider<TasksBloc>(
          create: (context) => TasksBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          final currentPalette = state.isDarkTheme ? darkPalette : lightPalette;
          return MaterialApp(
            theme: AppStyle(currentPalette).themeData,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            onGenerateTitle: (context) =>
                AppLocalizations.of(context)!.appTitle,
            home: const Scaffold(
              body: HomeScreen(),
            ),
          );
        },
      ),
    );
  }
}
