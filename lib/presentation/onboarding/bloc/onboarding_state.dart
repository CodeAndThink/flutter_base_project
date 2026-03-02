import 'package:equatable/equatable.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

class OnboardingInitial extends OnboardingState {}

class OnboardingLoading extends OnboardingState {}

class OnboardingLoaded extends OnboardingState {
  final bool hasCompleted;
  final int currentPage;

  const OnboardingLoaded({required this.hasCompleted, this.currentPage = 0});

  OnboardingLoaded copyWith({bool? hasCompleted, int? currentPage}) {
    return OnboardingLoaded(
      hasCompleted: hasCompleted ?? this.hasCompleted,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object> get props => [hasCompleted, currentPage];
}

class OnboardingError extends OnboardingState {
  final String message;

  const OnboardingError(this.message);

  @override
  List<Object> get props => [message];
}
