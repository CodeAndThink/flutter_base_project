import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_base_project/router/app_router.dart';
import 'package:flutter_base_project/core/common/theme/theme.dart';
import 'package:flutter_base_project/core/common/theme/theme_cubit.dart';

import 'package:flutter_base_project/core/database/local_storage_datasource.dart';
import 'package:flutter_base_project/data/repositories/onboarding_repository.dart';

import 'package:flutter_base_project/core/network/dio_client.dart';
import 'package:flutter_base_project/core/network/api_clients.dart';
import 'package:flutter_base_project/data/repositories/movie_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(MainApp(sharedPreferences: sharedPreferences));
}

class MainApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const MainApp({super.key, required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LocalStorageDataSource>(
          create: (context) =>
              LocalStorageDataSourceImpl(sharedPreferences: sharedPreferences),
        ),
        RepositoryProvider<OnboardingRepository>(
          create: (context) => OnboardingRepositoryImpl(
            localDataSource: context.read<LocalStorageDataSource>(),
          ),
        ),
        RepositoryProvider<DioClient>(create: (context) => DioClient()),
        RepositoryProvider<ApiClients>(
          create: (context) => ApiClients(context.read<DioClient>().dio),
        ),
        RepositoryProvider<MovieRepository>(
          create: (context) =>
              MovieRepositoryImpl(apiClient: context.read<ApiClients>()),
        ),
      ],
      child: BlocProvider(
        create: (context) => ThemeCubit(),
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp.router(
              title: 'Clean Architecture Onboarding',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
              routerConfig: AppRouter.router,
              debugShowCheckedModeBanner: false,
            );
          },
        ),
      ),
    );
  }
}
