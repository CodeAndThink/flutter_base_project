import 'package:flutter_base_project/data/repositories/onboarding_repository.dart';

class ClearOnboardingUseCase {
  final OnboardingRepository _repository;

  const ClearOnboardingUseCase(this._repository);

  Future<void> call() => _repository.clearOnboarding();
}
