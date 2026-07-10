import 'package:flutter_base_project/core/navigation/base_navigator.dart';
import 'package:flutter_base_project/router/app_router.dart';

class OnboardingNavigator extends BaseNavigator {
  OnboardingNavigator(super.context);

  void openHome() {
    goNamed(AppRouter.homeName);
  }
}
