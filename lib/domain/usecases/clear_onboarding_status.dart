import '../repositories/onboarding_repository.dart';

class ClearOnboardingStatus {
  final OnboardingRepository repository;

  ClearOnboardingStatus({required this.repository});

  Future<void> call() async {
    return await repository.clearOnboarding();
  }
}
