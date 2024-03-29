import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list_app/core/config/firebase_config_repository.dart';
import 'package:todo_list_app/core/data/managers/navigation_manager.dart';
import 'package:todo_list_app/core/data/managers/persistence_manager.dart';
import 'package:todo_list_app/core/domain/converters/hex_color_converter.dart';
import 'package:todo_list_app/core/domain/enums/environments.dart';
import 'package:todo_list_app/core/presentation/navigation/route_information_parser.dart';
import 'package:todo_list_app/core/presentation/styles/app_style.dart';
import 'package:todo_list_app/core/presentation/styles/app_theme.dart';
import 'package:todo_list_app/core/presentation/styles/palettes/dark_palette.dart';
import 'package:todo_list_app/core/presentation/styles/palettes/light_palette.dart';
import 'package:todo_list_app/core/presentation/widgets/environment_banner.dart';
import 'package:todo_list_app/features/tasks/data/repository/tasks_repository.dart';
import 'package:todo_list_app/features/tasks/presentation/bloc/tasks_bloc.dart';

class MainApp extends StatelessWidget {
  MainApp({required this.enviroment, super.key});
  final Environment enviroment;
  final _routerDelegate = GetIt.I<NavigationManager>().routerDelegate;
  final _routeInformationParser = CustomRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.platformBrightnessOf(context);
    final isDarkTheme = brightness == Brightness.dark;
    final currentPalette = isDarkTheme ? darkPalette : lightPalette;
    final shortestSide = MediaQuery.of(context).size.shortestSide;

    return ValueListenableBuilder(
      valueListenable:
          GetIt.I<FirebaseConfigRepository>().importantTaskColorNotifier,
      builder: (context, color, _) {
        currentPalette.colorImportantTask = getColorFromHex(color);
        return AppTheme(
          colors: currentPalette,
          child: MultiBlocProvider(
            providers: [
              BlocProvider<TasksBloc>(
                create: (context) => TasksBloc(
                  tasksRepository: GetIt.I<TasksRepository>(),
                  persistenceManager: GetIt.I<PersistenceManager>(),
                )..add(const LoadTasks()),
              ),
            ],
            child: EnvironmentBanner(
              environment: enviroment,
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                theme: AppStyle(currentPalette, shortestSide).themeData,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                onGenerateTitle: (context) =>
                    AppLocalizations.of(context)!.appTitle,
                routerDelegate: _routerDelegate,
                routeInformationParser: _routeInformationParser,
              ),
            ),
          ),
        );
      },
    );
  }
}
