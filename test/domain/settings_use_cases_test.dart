import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_base_project/core/constants/key_constants.dart';
import 'package:flutter_base_project/data/repositories/settings_repository.dart';
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
  test('theme_mode uses default when unset', () {
    expect(GetThemeModeUseCase(repository)(), 0);
  });
  test(
    'theme_mode persists and reloads the value using the existing key',
    () async {
      await SetThemeModeUseCase(repository)(1);
      expect(prefs.getInt(KeyConstants.themeMode), 1);
      expect(GetThemeModeUseCase(SettingsRepositoryImpl(prefs))(), 1);
    },
  );
  test('language_code uses default when unset', () {
    expect(GetLanguageCodeUseCase(repository)(), 'en');
  });
  test(
    'language_code persists and reloads the value using the existing key',
    () async {
      await SetLanguageCodeUseCase(repository)('vi');
      expect(prefs.getString('language_code'), 'vi');
      expect(GetLanguageCodeUseCase(SettingsRepositoryImpl(prefs))(), 'vi');
    },
  );
  test('haptic_enabled uses default when unset', () {
    expect(GetHapticEnabledUseCase(repository)(), true);
  });
  test(
    'haptic_enabled persists and reloads the value using the existing key',
    () async {
      await SetHapticEnabledUseCase(repository)(false);
      expect(prefs.getBool(KeyConstants.hapticEnabled), false);
      expect(GetHapticEnabledUseCase(SettingsRepositoryImpl(prefs))(), false);
    },
  );
  test('sound_enabled uses default when unset', () {
    expect(GetSoundEnabledUseCase(repository)(), true);
  });
  test(
    'sound_enabled persists and reloads the value using the existing key',
    () async {
      await SetSoundEnabledUseCase(repository)(false);
      expect(prefs.getBool(KeyConstants.soundEnabled), false);
      expect(GetSoundEnabledUseCase(SettingsRepositoryImpl(prefs))(), false);
    },
  );
  test('is_first_time uses default when unset', () {
    expect(GetIsFirstTimeUseCase(repository)(), true);
  });
  test(
    'is_first_time persists and reloads the value using the existing key',
    () async {
      await SetIsFirstTimeUseCase(repository)(false);
      expect(prefs.getBool('is_first_time'), false);
      expect(GetIsFirstTimeUseCase(SettingsRepositoryImpl(prefs))(), false);
    },
  );
}
