import 'package:equatable/equatable.dart';
import 'package:flutter_base_project/data/models/enum/load_status.dart';

class OnboardingState extends Equatable {
  final LoadStatus loadStatus;
  final bool hasCompleted;
  final int currentPage;

  const OnboardingState({
    this.loadStatus = LoadStatus.initial,
    this.hasCompleted = false,
    this.currentPage = 0,
  });

  @override
  List<Object> get props => [loadStatus, hasCompleted, currentPage];

  OnboardingState copyWith({
    LoadStatus? loadStatus,
    bool? hasCompleted,
    int? currentPage,
  }) {
    return OnboardingState(
      loadStatus: loadStatus ?? this.loadStatus,
      hasCompleted: hasCompleted ?? this.hasCompleted,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
