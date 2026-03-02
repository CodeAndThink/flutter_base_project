import 'package:go_router/go_router.dart';
import '../../presentation/home/pages/home_page.dart';
import '../../presentation/onboarding/pages/onboarding_page.dart';
import '../../presentation/home/pages/movie_detail_page.dart';

class AppRouter {
  static const String onboardingPath = '/';
  static const String onboardingName = 'onboarding';

  static const String homePath = '/home';
  static const String homeName = 'home';

  static const String movieDetailPath = '/movie/:id';
  static const String movieDetailName = 'movie_detail';

  static final router = GoRouter(
    initialLocation: onboardingPath,
    routes: [
      GoRoute(
        path: onboardingPath,
        name: onboardingName,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: homePath,
        name: homeName,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: movieDetailPath,
        name: movieDetailName,
        builder: (context, state) {
          final movieIdStr = state.pathParameters['id'];
          final movieId = int.tryParse(movieIdStr ?? '') ?? 0;
          return MovieDetailPage(movieId: movieId);
        },
      ),
    ],
  );
}
