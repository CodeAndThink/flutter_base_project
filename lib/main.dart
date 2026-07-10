import 'package:flutter/material.dart';
import 'package:flutter_base_project/generated/l10n.dart';
import 'package:flutter_base_project/presentation/app/locale_cubit.dart';
import 'package:flutter_base_project/presentation/app/theme_cubit.dart';
import 'package:flutter_base_project/presentation/app/theme_state.dart';
import 'package:flutter_base_project/presentation/theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_base_project/router/app_router.dart';

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
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ThemeCubit(sharedPreferences)),
          BlocProvider(create: (context) => LocaleCubit(sharedPreferences)),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          buildWhen: (previous, current) =>
              previous.themeMode != current.themeMode,
          builder: (context, state) {
            return BlocBuilder<LocaleCubit, LocaleState>(
              buildWhen: (previous, current) =>
                  previous.locale != current.locale,
              builder: (context, localeState) {
                return MaterialApp.router(
                  title: 'Clean Architecture Onboarding',
                  theme: AppTheme.light(),
                  darkTheme: AppTheme.dark(),
                  themeMode: state.themeMode,
                  routerConfig: AppRouter.router,
                  localizationsDelegates: const [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: S.delegate.supportedLocales,
                  locale: Locale(localeState.locale.value),
                  debugShowCheckedModeBanner: false,
                  builder: (context, child) {
                    return MediaQuery(
                      data: MediaQuery.of(context).copyWith(
                        textScaler: const TextScaler.linear(1.0),
                        boldText: false,
                      ),
                      child: child!,
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
