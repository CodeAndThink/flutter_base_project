import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../support/fakes.dart';
import 'package:flutter_base_project/core/constants/key_constants.dart';
import 'package:flutter_base_project/data/repositories/settings_repository.dart';
import 'package:flutter_base_project/data/models/enum/language_type.dart';
import 'package:flutter_base_project/presentation/app/theme_cubit.dart';
import 'package:flutter_base_project/presentation/app/locale_cubit.dart';
import 'package:flutter_base_project/presentation/app/interaction_cubit.dart';
import 'package:flutter_base_project/presentation/app/app_cubit.dart';
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

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late SharedPreferences prefs;
  late SettingsRepository repository;
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    repository = SettingsRepositoryImpl(prefs);
  });
  ThemeCubit themeCubit() => ThemeCubit(
    getThemeMode: GetThemeModeUseCase(repository),
    setThemeMode: SetThemeModeUseCase(repository),
  );
  LocaleCubit localeCubit() => LocaleCubit(
    getLanguageCode: GetLanguageCodeUseCase(repository),
    setLanguageCode: SetLanguageCodeUseCase(repository),
  );
  InteractionCubit interactionCubit() => InteractionCubit(
    getHapticEnabled: GetHapticEnabledUseCase(repository),
    setHapticEnabled: SetHapticEnabledUseCase(repository),
    getSoundEnabled: GetSoundEnabledUseCase(repository),
    setSoundEnabled: SetSoundEnabledUseCase(repository),
  );
  test('theme defaults to system and toggles light then dark', () async {
    final cubit = themeCubit();
    addTearDown(cubit.close);
    expect(cubit.state.themeMode, ThemeMode.system);
    cubit.toggleTheme();
    expect(cubit.state.themeMode, ThemeMode.light);
    expect(prefs.getInt(KeyConstants.themeMode), 1);
    cubit.toggleTheme();
    expect(cubit.state.themeMode, ThemeMode.dark);
    expect(prefs.getInt(KeyConstants.themeMode), 2);
  });
  test('theme restores saved preference and allows system mode', () async {
    await prefs.setInt(KeyConstants.themeMode, 2);
    final cubit = themeCubit();
    addTearDown(cubit.close);
    expect(cubit.state.themeMode, ThemeMode.dark);
    cubit.updateTheme(mode: ThemeMode.system);
    expect(cubit.state.themeMode, ThemeMode.system);
    expect(prefs.getInt(KeyConstants.themeMode), 0);
  });
  test('locale toggles and persists both languages', () {
    final cubit = localeCubit();
    addTearDown(cubit.close);
    expect(cubit.state.locale, LanguageType.en);
    cubit.toggleLocale();
    expect(cubit.state.locale, LanguageType.vi);
    expect(prefs.getString('language_code'), 'vi');
    cubit.toggleLocale();
    expect(cubit.state.locale, LanguageType.en);
    expect(prefs.getString('language_code'), 'en');
  });
  test('locale restores saved language', () async {
    await prefs.setString('language_code', 'vi');
    final cubit = localeCubit();
    addTearDown(cubit.close);
    expect(cubit.state.locale, LanguageType.vi);
  });
  test('interaction settings toggle independently and persist', () {
    final cubit = interactionCubit();
    addTearDown(cubit.close);
    expect(cubit.state.hapticEnabled, isTrue);
    expect(cubit.state.soundEnabled, isTrue);
    cubit.toggleHaptic();
    expect(cubit.state.hapticEnabled, isFalse);
    expect(cubit.state.soundEnabled, isTrue);
    expect(prefs.getBool(KeyConstants.hapticEnabled), isFalse);
    cubit.toggleSound();
    expect(cubit.state.soundEnabled, isFalse);
    expect(prefs.getBool(KeyConstants.soundEnabled), isFalse);
    cubit.toggleHaptic();
    cubit.toggleSound();
    expect(cubit.state.hapticEnabled, isTrue);
    expect(cubit.state.soundEnabled, isTrue);
  });
  test('interaction restores saved values', () async {
    await prefs.setBool(KeyConstants.hapticEnabled, false);
    await prefs.setBool(KeyConstants.soundEnabled, false);
    final cubit = interactionCubit();
    addTearDown(cubit.close);
    expect(cubit.state.hapticEnabled, isFalse);
    expect(cubit.state.soundEnabled, isFalse);
  });
  test(
    'app completes first launch and disposes connection monitoring',
    () async {
      final connection = FakeConnectionService();
      final cubit = AppCubit(
        connection,
        getIsFirstTime: GetIsFirstTimeUseCase(repository),
        setIsFirstTime: SetIsFirstTimeUseCase(repository),
      );
      addTearDown(() async {
        if (!cubit.isClosed) await cubit.close();
      });
      expect(connection.started, isTrue);
      expect(cubit.state.isFirstTime, isTrue);
      await cubit.completeOnboarding();
      expect(cubit.state.isFirstTime, isFalse);
      expect(prefs.getBool('is_first_time'), isFalse);
      await cubit.close();
      expect(connection.disposed, isTrue);
    },
  );
  test('app restores completed first launch', () async {
    await prefs.setBool('is_first_time', false);
    final cubit = AppCubit(
      FakeConnectionService(),
      getIsFirstTime: GetIsFirstTimeUseCase(repository),
      setIsFirstTime: SetIsFirstTimeUseCase(repository),
    );
    addTearDown(cubit.close);
    expect(cubit.state.isFirstTime, isFalse);
  });
}
