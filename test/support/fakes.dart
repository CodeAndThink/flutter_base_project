import 'package:dart_either/dart_either.dart';
import 'package:flutter_base_project/core/failure/app_failure.dart';
import 'package:flutter_base_project/core/services/connection_service.dart';
import 'package:flutter_base_project/data/models/response/movie_model.dart';
import 'package:flutter_base_project/data/repositories/movie_repository.dart';
import 'package:flutter_base_project/data/repositories/onboarding_repository.dart';
import 'package:flutter_base_project/presentation/features/home/home_navigator.dart';
import 'package:flutter_base_project/presentation/features/detail/movie_detail_navigator.dart';
import 'package:flutter_base_project/presentation/features/detail/movie_detail_page.dart';
import 'package:flutter_base_project/presentation/features/onboarding/onboarding_navigator.dart';

class FakeMovieRepository implements MovieRepository {
  Either<Failure, List<MovieModel>> popular = const Right([]);
  Either<Failure, MovieModel> detail = const Right(MovieModel(id: 42));
  int? requestedId;
  @override
  Future<Either<Failure, List<MovieModel>>> getPopularMovies() async => popular;
  @override
  Future<Either<Failure, MovieModel>> getMovieDetails(int id) async {
    requestedId = id;
    return detail;
  }
}

class FakeOnboardingRepository implements OnboardingRepository {
  bool completed = false;
  Object? error;
  void checkError() {
    if (error != null) throw error!;
  }

  @override
  Future<bool> hasCompletedOnboarding() async {
    checkError();
    return completed;
  }

  @override
  Future<void> completeOnboarding() async {
    checkError();
    completed = true;
  }

  @override
  Future<void> clearOnboarding() async {
    checkError();
    completed = false;
  }
}

// Only navigation methods under test are supported; unexpected calls fail.
class FakeHomeNavigator implements HomeNavigator {
  int? openedId;
  @override
  void openMovieDetail({required MovieDetailArgument args}) {
    openedId = args.movieId;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeDetailNavigator implements MovieDetailNavigator {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeOnboardingNavigator implements OnboardingNavigator {
  int homeVisits = 0;
  @override
  void openHome() {
    homeVisits++;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeConnectionService implements ConnectionService {
  bool started = false;
  bool disposed = false;
  @override
  void init() {
    started = true;
  }

  @override
  void dispose() {
    disposed = true;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
