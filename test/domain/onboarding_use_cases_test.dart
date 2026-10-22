import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../support/fakes.dart';
import 'package:flutter_base_project/core/database/local_storage_datasource.dart';
import 'package:flutter_base_project/data/repositories/onboarding_repository.dart';
import 'package:flutter_base_project/domain/usecases/onboarding/has_completed_onboarding_use_case.dart';
import 'package:flutter_base_project/domain/usecases/onboarding/complete_onboarding_use_case.dart';
import 'package:flutter_base_project/domain/usecases/onboarding/clear_onboarding_use_case.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('onboarding can be completed, reloaded and reset', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    OnboardingRepository repository() => OnboardingRepositoryImpl(
      localDataSource: LocalStorageDataSourceImpl(sharedPreferences: prefs),
    );
    expect(await HasCompletedOnboardingUseCase(repository())(), isFalse);
    await CompleteOnboardingUseCase(repository())();
    expect(prefs.getBool('hasCompletedOnboarding'), isTrue);
    expect(await HasCompletedOnboardingUseCase(repository())(), isTrue);
    await ClearOnboardingUseCase(repository())();
    expect(prefs.containsKey('hasCompletedOnboarding'), isFalse);
    expect(await HasCompletedOnboardingUseCase(repository())(), isFalse);
  });
  test('onboarding use cases propagate storage errors', () async {
    final error = StateError('Storage unavailable');
    final repository = FakeOnboardingRepository()..error = error;
    await expectLater(
      HasCompletedOnboardingUseCase(repository)(),
      throwsA(same(error)),
    );
    await expectLater(
      CompleteOnboardingUseCase(repository)(),
      throwsA(same(error)),
    );
    await expectLater(
      ClearOnboardingUseCase(repository)(),
      throwsA(same(error)),
    );
  });
}
