import 'package:flutter_base_project/data/repositories/settings_repository.dart';
import 'package:flutter_base_project/domain/usecases/movie/get_popular_movies_use_case.dart';
import 'package:flutter_base_project/domain/usecases/movie/get_movie_details_use_case.dart';
import 'package:flutter_base_project/domain/usecases/onboarding/has_completed_onboarding_use_case.dart';
import 'package:flutter_base_project/domain/usecases/onboarding/complete_onboarding_use_case.dart';
import 'package:flutter_base_project/domain/usecases/onboarding/clear_onboarding_use_case.dart';
import 'package:flutter_base_project/domain/usecases/settings/get_theme_mode_use_case.dart';
import 'package:flutter_base_project/domain/usecases/settings/set_theme_mode_use_case.dart';
import 'package:flutter_base_project/domain/usecases/settings/get_language_code_use_case.dart';
import 'package:flutter_base_project/domain/usecases/settings/set_language_code_use_case.dart';
import 'package:flutter_base_project/domain/usecases/settings/get_haptic_enabled_use_case.dart';
import 'package:flutter_base_project/domain/usecases/settings/set_haptic_enabled_use_case.dart';
import 'package:flutter_base_project/domain/usecases/settings/get_sound_enabled_use_case.dart';
import 'package:flutter_base_project/domain/usecases/settings/set_sound_enabled_use_case.dart';
import 'package:flutter_base_project/domain/usecases/settings/get_is_first_time_use_case.dart';
import 'package:flutter_base_project/domain/usecases/settings/set_is_first_time_use_case.dart';
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
        RepositoryProvider<GetPopularMoviesUseCase>(
          create: (context) =>
              GetPopularMoviesUseCase(context.read<MovieRepository>()),
        ),
        RepositoryProvider<GetMovieDetailsUseCase>(
          create: (context) =>
              GetMovieDetailsUseCase(context.read<MovieRepository>()),
        ),
        RepositoryProvider<HasCompletedOnboardingUseCase>(
          create: (context) => HasCompletedOnboardingUseCase(
            context.read<OnboardingRepository>(),
          ),
        ),
        RepositoryProvider<CompleteOnboardingUseCase>(
          create: (context) =>
              CompleteOnboardingUseCase(context.read<OnboardingRepository>()),
        ),
        RepositoryProvider<ClearOnboardingUseCase>(
          create: (context) =>
              ClearOnboardingUseCase(context.read<OnboardingRepository>()),
        ),
        RepositoryProvider<SettingsRepository>(
          create: (context) => SettingsRepositoryImpl(sharedPreferences),
        ),
        RepositoryProvider<GetThemeModeUseCase>(
          create: (context) =>
              GetThemeModeUseCase(context.read<SettingsRepository>()),
        ),
        RepositoryProvider<SetThemeModeUseCase>(
          create: (context) =>
              SetThemeModeUseCase(context.read<SettingsRepository>()),
        ),
        RepositoryProvider<GetLanguageCodeUseCase>(
          create: (context) =>
              GetLanguageCodeUseCase(context.read<SettingsRepository>()),
        ),
        RepositoryProvider<SetLanguageCodeUseCase>(
          create: (context) =>
              SetLanguageCodeUseCase(context.read<SettingsRepository>()),
        ),
        RepositoryProvider<GetHapticEnabledUseCase>(
          create: (context) =>
              GetHapticEnabledUseCase(context.read<SettingsRepository>()),
        ),
        RepositoryProvider<SetHapticEnabledUseCase>(
          create: (context) =>
              SetHapticEnabledUseCase(context.read<SettingsRepository>()),
        ),
        RepositoryProvider<GetSoundEnabledUseCase>(
          create: (context) =>
              GetSoundEnabledUseCase(context.read<SettingsRepository>()),
        ),
        RepositoryProvider<SetSoundEnabledUseCase>(
          create: (context) =>
              SetSoundEnabledUseCase(context.read<SettingsRepository>()),
        ),
        RepositoryProvider<GetIsFirstTimeUseCase>(
          create: (context) =>
              GetIsFirstTimeUseCase(context.read<SettingsRepository>()),
        ),
        RepositoryProvider<SetIsFirstTimeUseCase>(
          create: (context) =>
              SetIsFirstTimeUseCase(context.read<SettingsRepository>()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ThemeCubit(
              getThemeMode: context.read<GetThemeModeUseCase>(),
              setThemeMode: context.read<SetThemeModeUseCase>(),
            ),
          ),
          BlocProvider(
            create: (context) => LocaleCubit(
              getLanguageCode: context.read<GetLanguageCodeUseCase>(),
              setLanguageCode: context.read<SetLanguageCodeUseCase>(),
            ),
          ),
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
