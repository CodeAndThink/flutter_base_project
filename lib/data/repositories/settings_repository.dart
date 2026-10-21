import 'package:flutter_base_project/core/constants/key_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsRepository {
  int getThemeMode();
  Future<void> setThemeMode(int value);
  String getLanguageCode();
  Future<void> setLanguageCode(String value);
  bool getHapticEnabled();
  Future<void> setHapticEnabled(bool value);
  bool getSoundEnabled();
  Future<void> setSoundEnabled(bool value);
  bool getIsFirstTime();
  Future<void> setIsFirstTime(bool value);
}

class SettingsRepositoryImpl implements SettingsRepository {
  final SharedPreferences _prefs;
  SettingsRepositoryImpl(this._prefs);

  @override
  int getThemeMode() => _prefs.getInt(KeyConstants.themeMode) ?? 0;

  @override
  Future<void> setThemeMode(int value) async {
    await _prefs.setInt(KeyConstants.themeMode, value);
  }

  @override
  String getLanguageCode() => _prefs.getString('language_code') ?? 'en';

  @override
  Future<void> setLanguageCode(String value) async {
    await _prefs.setString('language_code', value);
  }

  @override
  bool getHapticEnabled() => _prefs.getBool(KeyConstants.hapticEnabled) ?? true;

  @override
  Future<void> setHapticEnabled(bool value) async {
    await _prefs.setBool(KeyConstants.hapticEnabled, value);
  }

  @override
  bool getSoundEnabled() => _prefs.getBool(KeyConstants.soundEnabled) ?? true;

  @override
  Future<void> setSoundEnabled(bool value) async {
    await _prefs.setBool(KeyConstants.soundEnabled, value);
  }

  @override
  bool getIsFirstTime() => _prefs.getBool('is_first_time') ?? true;

  @override
  Future<void> setIsFirstTime(bool value) async {
    await _prefs.setBool('is_first_time', value);
  }
}
