import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorageDataSource {
  Future<bool> getOnboardingStatus();
  Future<void> saveOnboardingStatus();
  Future<void> clearOnboardingStatus();
}

class LocalStorageDataSourceImpl implements LocalStorageDataSource {
  final SharedPreferences sharedPreferences;
  static const String onboardingKey = 'hasCompletedOnboarding';

  LocalStorageDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> getOnboardingStatus() async {
    return sharedPreferences.getBool(onboardingKey) ?? false;
  }

  @override
  Future<void> saveOnboardingStatus() async {
    await sharedPreferences.setBool(onboardingKey, true);
  }

  @override
  Future<void> clearOnboardingStatus() async {
    await sharedPreferences.remove(onboardingKey);
  }
}
