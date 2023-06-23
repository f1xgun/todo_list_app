import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_list_app/core/constants/app_route_constants.dart';
import 'package:todo_list_app/core/styles/app_style.dart';
import 'package:todo_list_app/core/styles/palettes/dark_palette.dart';
import 'package:todo_list_app/core/styles/palettes/light_palette.dart';
import 'package:todo_list_app/core/styles/theme/bloc/theme_bloc.dart';
import 'package:todo_list_app/core/utils/managers/network_manager.dart';
import 'package:todo_list_app/core/utils/managers/persistence_manager.dart';
import 'package:todo_list_app/features/home/presentation/home_screen.dart';
import 'package:todo_list_app/features/task_details_screen/presentation/task_details_screen.dart';
import 'package:todo_list_app/features/tasks/data/api/local_storage_tasks_api.dart';
import 'package:todo_list_app/features/tasks/data/repository/tasks_repository.dart';
import 'package:todo_list_app/features/tasks/presentation/bloc/tasks_bloc.dart';

class MainApp extends StatelessWidget {
  const MainApp({required this.localStorage, super.key});

  final LocalStorageTasksApi localStorage;

  @override
  Widget build(BuildContext context) {
    final persistenceManager = PersistenceManager();
    final networkManager =
        NetworkManager(persistenceManager: persistenceManager);
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(
            isDark: PlatformDispatcher.instance.platformBrightness ==
                Brightness.dark,
          ),
        ),
        BlocProvider<TasksBloc>(
          create: (context) => TasksBloc(
            tasksRepository: TasksRepository(
              localStorage: localStorage,
              persistenceManager: persistenceManager,
              networkManager: networkManager,
            ),
          )..add(const LoadTasks()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          final currentPalette = state.isDarkTheme ? darkPalette : lightPalette;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppStyle(currentPalette).themeData,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            onGenerateTitle: (context) =>
                AppLocalizations.of(context)!.appTitle,
            initialRoute: AppRoutes.homeRoute,
            routes: <String, WidgetBuilder>{
              AppRoutes.homeRoute: (context) => const HomeScreen(),
              AppRoutes.taskDetailRoute: (context) => const TaskDetailsScreen()
            },
          );
        },
      ),
    );
  }
}
