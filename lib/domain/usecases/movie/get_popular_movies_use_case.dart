import 'package:flutter_base_project/data/repositories/movie_repository.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter_base_project/core/failure/app_failure.dart';
import 'package:flutter_base_project/data/models/response/movie_model.dart';

class GetPopularMoviesUseCase {
  final MovieRepository _repository;

  const GetPopularMoviesUseCase(this._repository);

  Future<Either<Failure, List<MovieModel>>> call() =>
      _repository.getPopularMovies();
}
