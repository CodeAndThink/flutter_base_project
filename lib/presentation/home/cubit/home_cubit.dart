import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/clear_onboarding_status.dart';

class HomeCubit extends Cubit<void> {
  final ClearOnboardingStatus clearOnboardingStatus;

  HomeCubit({required this.clearOnboardingStatus}) : super(null);

  Future<void> resetOnboarding() async {
    await clearOnboardingStatus();
  }
}
