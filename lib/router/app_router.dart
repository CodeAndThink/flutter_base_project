import 'package:go_router/go_router.dart';
import 'package:flutter_base_project/ui/pages/home/page/home_page.dart';
import 'package:flutter_base_project/ui/pages/onboarding/page/onboarding_page.dart';
import 'package:flutter_base_project/ui/pages/detail/page/movie_detail_page.dart';

class AppRouter {
  static const String onboardingPath = '/';
  static const String onboardingName = 'onboarding';

  static const String homePath = '/home';
  static const String homeName = 'home';

  static const String movieDetailDeeplinkPath =
      '/movie/:id'; // Path with parameter
  static const String movieDetailDeeplinkName = 'movie_detail_deeplink';
  static const String movieDetailPath = '/movie'; // Path without parameter
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
        path: movieDetailDeeplinkPath,
        name: movieDetailDeeplinkName,
        builder: (context, state) {
          final movieIdStr = state.pathParameters['id'];
          final movieId = int.tryParse(movieIdStr ?? '') ?? 0;
          return MovieDetailPage(args: MovieDetailArgument(movieId: movieId));
        },
      ),
      GoRoute(
        path: movieDetailPath,
        name: movieDetailName,
        builder: (context, state) {
          final args = state.extra as MovieDetailArgument;

          return MovieDetailPage(args: args);
        },
      ),
    ],
  );
}
