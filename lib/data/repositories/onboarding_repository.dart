import 'package:flutter_base_project/core/database/local_storage_datasource.dart';

abstract class OnboardingRepository {
  Future<bool> hasCompletedOnboarding();
  Future<void> completeOnboarding();
  Future<void> clearOnboarding();
}

class OnboardingRepositoryImpl implements OnboardingRepository {
  final LocalStorageDataSource localDataSource;

  OnboardingRepositoryImpl({required this.localDataSource});

  @override
  Future<bool> hasCompletedOnboarding() async {
    return await localDataSource.getOnboardingStatus();
  }

  @override
  Future<void> completeOnboarding() async {
    await localDataSource.saveOnboardingStatus();
  }

  @override
  Future<void> clearOnboarding() async {
    await localDataSource.clearOnboardingStatus();
  }
}
