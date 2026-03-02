import '../repositories/onboarding_repository.dart';

class SaveOnboardingStatus {
  final OnboardingRepository repository;

  SaveOnboardingStatus({required this.repository});

  Future<void> call() async {
    return await repository.completeOnboarding();
  }
}
