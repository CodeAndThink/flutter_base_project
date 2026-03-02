abstract class OnboardingRepository {
  Future<bool> hasCompletedOnboarding();
  Future<void> completeOnboarding();
  Future<void> clearOnboarding();
}
