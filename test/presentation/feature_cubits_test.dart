import 'package:flutter_test/flutter_test.dart';
import 'package:dart_either/dart_either.dart';
import '../support/fakes.dart';
import 'package:flutter_base_project/core/failure/app_failure.dart';
import 'package:flutter_base_project/data/models/response/movie_model.dart';
import 'package:flutter_base_project/data/models/enum/load_status.dart';
import 'package:flutter_base_project/domain/usecases/movie/get_popular_movies_use_case.dart';
import 'package:flutter_base_project/domain/usecases/movie/get_movie_details_use_case.dart';
import 'package:flutter_base_project/domain/usecases/onboarding/clear_onboarding_use_case.dart';
import 'package:flutter_base_project/domain/usecases/onboarding/complete_onboarding_use_case.dart';
import 'package:flutter_base_project/domain/usecases/onboarding/has_completed_onboarding_use_case.dart';
import 'package:flutter_base_project/presentation/features/home/home_cubit.dart';
import 'package:flutter_base_project/presentation/features/detail/movie_detail_cubit.dart';
import 'package:flutter_base_project/presentation/features/onboarding/onboarding_cubit.dart';

void main() {
  group('HomeCubit', () {
    late FakeMovieRepository movies;
    late FakeOnboardingRepository onboarding;
    late FakeHomeNavigator navigator;
    late HomeCubit cubit;
    setUp(() {
      movies = FakeMovieRepository();
      onboarding = FakeOnboardingRepository();
      navigator = FakeHomeNavigator();
      cubit = HomeCubit(
        getPopularMovies: GetPopularMoviesUseCase(movies),
        clearOnboarding: ClearOnboardingUseCase(onboarding),
        navigator: navigator,
      );
    });
    tearDown(() => cubit.close());
    test('loads movies through loading and success states', () async {
      movies.popular = const Right([MovieModel(id: 7)]);
      final states = expectLater(
        cubit.stream.map((s) => s.fetchPopularMoviesStatus),
        emitsInOrder([LoadStatus.loading, LoadStatus.success]),
      );
      await cubit.fetchPopularMovies();
      await states;
      expect(cubit.state.movies.single.id, 7);
    });
    test('empty movies is a successful result', () async {
      await cubit.fetchPopularMovies();
      expect(cubit.state.fetchPopularMoviesStatus, LoadStatus.success);
      expect(cubit.state.movies, isEmpty);
    });
    test('failure can be retried successfully', () async {
      movies.popular = const Left(NetworkFailure());
      final states = expectLater(
        cubit.stream.map((s) => s.fetchPopularMoviesStatus),
        emitsInOrder([
          LoadStatus.loading,
          LoadStatus.failure,
          LoadStatus.loading,
          LoadStatus.success,
        ]),
      );
      await cubit.fetchPopularMovies();
      movies.popular = const Right([MovieModel(id: 9)]);
      await cubit.fetchPopularMovies();
      await states;
      expect(cubit.state.movies.single.id, 9);
    });
    test('resets onboarding', () async {
      onboarding.completed = true;
      await cubit.resetOnboarding();
      expect(onboarding.completed, isFalse);
    });
    test('opens the selected movie', () {
      cubit.openMovieDetail(movieId: 93);
      expect(navigator.openedId, 93);
    });
  });
  group('MovieDetailCubit', () {
    late FakeMovieRepository repository;
    late MovieDetailCubit cubit;
    setUp(() {
      repository = FakeMovieRepository();
      cubit = MovieDetailCubit(
        getMovieDetails: GetMovieDetailsUseCase(repository),
        navigator: FakeDetailNavigator(),
      );
    });
    tearDown(() => cubit.close());
    test('loads the requested movie', () async {
      final states = expectLater(
        cubit.stream.map((s) => s.fetchMovieDetailsStatus),
        emitsInOrder([LoadStatus.loading, LoadStatus.success]),
      );
      await cubit.fetchMovieDetails(42);
      await states;
      expect(repository.requestedId, 42);
      expect(cubit.state.movie?.id, 42);
    });
    test('reports a repository failure', () async {
      repository.detail = const Left(NotFoundFailure());
      final states = expectLater(
        cubit.stream.map((s) => s.fetchMovieDetailsStatus),
        emitsInOrder([LoadStatus.loading, LoadStatus.failure]),
      );
      await cubit.fetchMovieDetails(404);
      await states;
      expect(cubit.state.movie, isNull);
    });
  });
  group('OnboardingCubit', () {
    late FakeOnboardingRepository repository;
    late FakeOnboardingNavigator navigator;
    late OnboardingCubit cubit;
    setUp(() {
      repository = FakeOnboardingRepository();
      navigator = FakeOnboardingNavigator();
      cubit = OnboardingCubit(
        hasCompletedOnboarding: HasCompletedOnboardingUseCase(repository),
        completeOnboardingUseCase: CompleteOnboardingUseCase(repository),
        navigator: navigator,
      );
    });
    tearDown(() => cubit.close());
    test('new user stays on onboarding', () async {
      final states = expectLater(
        cubit.stream.map((s) => s.loadStatus),
        emitsInOrder([LoadStatus.loading, LoadStatus.success]),
      );
      await cubit.checkIfOnboardingCompleted();
      await states;
      expect(cubit.state.hasCompleted, isFalse);
      expect(navigator.homeVisits, 0);
    });
    test('returning user opens home', () async {
      repository.completed = true;
      await cubit.checkIfOnboardingCompleted();
      expect(navigator.homeVisits, 1);
    });
    test('completion persists status before opening home', () async {
      await cubit.completeOnboarding();
      expect(repository.completed, isTrue);
      expect(cubit.state.hasCompleted, isTrue);
      expect(navigator.homeVisits, 1);
    });
    test('read error displays failure without navigating', () async {
      repository.error = StateError('Read failed');
      await cubit.checkIfOnboardingCompleted();
      expect(cubit.state.loadStatus, LoadStatus.failure);
      expect(navigator.homeVisits, 0);
    });
    test('write error does not mark completion or navigate', () async {
      repository.error = StateError('Write failed');
      await cubit.completeOnboarding();
      expect(cubit.state.loadStatus, LoadStatus.failure);
      expect(cubit.state.hasCompleted, isFalse);
      expect(navigator.homeVisits, 0);
    });
    test('page change updates current page', () {
      cubit.pageChanged(2);
      expect(cubit.state.currentPage, 2);
      expect(cubit.state.hasCompleted, isFalse);
    });
  });
}
