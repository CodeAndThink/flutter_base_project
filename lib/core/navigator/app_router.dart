import 'package:go_router/go_router.dart';
import '../../presentation/home/pages/home_page.dart';
import '../../presentation/onboarding/pages/onboarding_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const OnboardingPage()),
      GoRoute(path: '/home', builder: (context, state) => const HomePage()),
    ],
  );
}
