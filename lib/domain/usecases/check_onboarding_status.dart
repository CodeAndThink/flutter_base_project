import '../repositories/onboarding_repository.dart';

class CheckOnboardingStatus {
  final OnboardingRepository repository;

  CheckOnboardingStatus({required this.repository});

  Future<bool> call() async {
    return await repository.hasCompletedOnboarding();
  }
}
