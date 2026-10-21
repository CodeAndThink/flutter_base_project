import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_project/domain/usecases/onboarding/has_completed_onboarding_use_case.dart';
import 'package:flutter_base_project/domain/usecases/onboarding/complete_onboarding_use_case.dart';
import 'package:flutter_base_project/data/models/enum/load_status.dart';
import 'onboarding_state.dart';
import 'onboarding_navigator.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final HasCompletedOnboardingUseCase hasCompletedOnboarding;
  final CompleteOnboardingUseCase completeOnboardingUseCase;
  final OnboardingNavigator navigator;

  OnboardingCubit({
    required this.hasCompletedOnboarding,
    required this.completeOnboardingUseCase,
    required this.navigator,
  }) : super(const OnboardingState());

  Future<void> checkIfOnboardingCompleted() async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    try {
      final hasCompleted = await hasCompletedOnboarding();
      if (hasCompleted) {
        openHome();
      } else {
        emit(
          state.copyWith(
            loadStatus: LoadStatus.success,
            hasCompleted: hasCompleted,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }

  Future<void> completeOnboarding() async {
    try {
      await completeOnboardingUseCase();
      emit(state.copyWith(hasCompleted: true));
      openHome();
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }

  void pageChanged(int pageIndex) {
    emit(state.copyWith(currentPage: pageIndex));
  }

  void openHome() {
    navigator.openHome();
  }
}
