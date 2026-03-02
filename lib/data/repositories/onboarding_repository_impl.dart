import '../../domain/repositories/onboarding_repository.dart';
import '../datasources/local_storage_datasource.dart';

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
