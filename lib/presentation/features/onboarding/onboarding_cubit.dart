import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_project/data/repositories/onboarding_repository.dart';
import 'package:flutter_base_project/data/models/enum/load_status.dart';
import 'onboarding_state.dart';
import 'onboarding_navigator.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final OnboardingRepository repository;
  final OnboardingNavigator navigator;

  OnboardingCubit({required this.repository, required this.navigator})
    : super(const OnboardingState());

  Future<void> checkIfOnboardingCompleted() async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    try {
      final hasCompleted = await repository.hasCompletedOnboarding();
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
      await repository.completeOnboarding();
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
