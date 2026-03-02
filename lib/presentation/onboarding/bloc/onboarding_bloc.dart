import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/check_onboarding_status.dart';
import '../../../domain/usecases/save_onboarding_status.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final CheckOnboardingStatus checkOnboardingStatus;
  final SaveOnboardingStatus saveOnboardingStatus;

  OnboardingBloc({
    required this.checkOnboardingStatus,
    required this.saveOnboardingStatus,
  }) : super(OnboardingInitial()) {
    on<CheckIfOnboardingCompleted>(_onCheckIfOnboardingCompleted);
    on<CompleteOnboarding>(_onCompleteOnboarding);
    on<PageChanged>(_onPageChanged);
  }

  Future<void> _onCheckIfOnboardingCompleted(
    CheckIfOnboardingCompleted event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(OnboardingLoading());
    try {
      final hasCompleted = await checkOnboardingStatus();
      emit(OnboardingLoaded(hasCompleted: hasCompleted));
    } catch (e) {
      emit(const OnboardingError('Failed to check onboarding status.'));
    }
  }

  Future<void> _onCompleteOnboarding(
    CompleteOnboarding event,
    Emitter<OnboardingState> emit,
  ) async {
    if (state is OnboardingLoaded) {
      final currentState = state as OnboardingLoaded;
      try {
        await saveOnboardingStatus();
        emit(currentState.copyWith(hasCompleted: true));
      } catch (e) {
        emit(const OnboardingError('Failed to save onboarding status.'));
      }
    }
  }

  void _onPageChanged(PageChanged event, Emitter<OnboardingState> emit) {
    if (state is OnboardingLoaded) {
      final currentState = state as OnboardingLoaded;
      emit(currentState.copyWith(currentPage: event.pageIndex));
    }
  }
}
