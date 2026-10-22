import 'package:flutter_base_project/data/repositories/onboarding_repository.dart';

class HasCompletedOnboardingUseCase {
  final OnboardingRepository _repository;

  const HasCompletedOnboardingUseCase(this._repository);

  Future<bool> call() => _repository.hasCompletedOnboarding();
}
