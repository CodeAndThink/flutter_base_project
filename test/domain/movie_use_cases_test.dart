import 'package:flutter_test/flutter_test.dart';
import 'package:dart_either/dart_either.dart';
import '../support/fakes.dart';
import 'package:flutter_base_project/core/failure/app_failure.dart';
import 'package:flutter_base_project/data/models/response/movie_model.dart';
import 'package:flutter_base_project/domain/usecases/movie/get_popular_movies_use_case.dart';
import 'package:flutter_base_project/domain/usecases/movie/get_movie_details_use_case.dart';

void main() {
  late FakeMovieRepository repository;
  setUp(() => repository = FakeMovieRepository());
  test('popular movies preserves the returned data', () async {
    const movies = [MovieModel(id: 7, titleLocal: 'Example')];
    repository.popular = const Right(movies);
    (await GetPopularMoviesUseCase(repository)()).fold(
      ifLeft: (_) => fail('Expected movies'),
      ifRight: (value) => expect(value, movies),
    );
  });
  test('popular movies accepts an empty result', () async {
    (await GetPopularMoviesUseCase(repository)()).fold(
      ifLeft: (_) => fail('Expected empty list'),
      ifRight: (value) => expect(value, isEmpty),
    );
  });
  test(
    'movie detail forwards the requested ID and returns the movie',
    () async {
      (await GetMovieDetailsUseCase(repository)(42)).fold(
        ifLeft: (_) => fail('Expected movie'),
        ifRight: (value) => expect(value.id, 42),
      );
      expect(repository.requestedId, 42);
    },
  );
  test('movie use cases preserve repository failures', () async {
    const failure = NetworkFailure();
    repository.popular = const Left(failure);
    repository.detail = const Left(failure);
    (await GetPopularMoviesUseCase(repository)()).fold(
      ifLeft: (value) => expect(value, same(failure)),
      ifRight: (_) => fail('Expected failure'),
    );
    (await GetMovieDetailsUseCase(repository)(42)).fold(
      ifLeft: (value) => expect(value, same(failure)),
      ifRight: (_) => fail('Expected failure'),
    );
  });
}
