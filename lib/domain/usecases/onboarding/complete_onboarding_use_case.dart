import 'package:flutter_base_project/data/repositories/onboarding_repository.dart';

class CompleteOnboardingUseCase {
  final OnboardingRepository _repository;

  const CompleteOnboardingUseCase(this._repository);

  Future<void> call() => _repository.completeOnboarding();
}
