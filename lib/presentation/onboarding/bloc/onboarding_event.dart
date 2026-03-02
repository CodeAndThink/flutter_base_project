import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object> get props => [];
}

class CheckIfOnboardingCompleted extends OnboardingEvent {}

class CompleteOnboarding extends OnboardingEvent {}

class PageChanged extends OnboardingEvent {
  final int pageIndex;

  const PageChanged(this.pageIndex);

  @override
  List<Object> get props => [pageIndex];
}
