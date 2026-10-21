import 'package:flutter_base_project/data/repositories/movie_repository.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter_base_project/core/failure/app_failure.dart';
import 'package:flutter_base_project/data/models/response/movie_model.dart';

class GetMovieDetailsUseCase {
  final MovieRepository _repository;

  const GetMovieDetailsUseCase(this._repository);

  Future<Either<Failure, MovieModel>> call(int id) =>
      _repository.getMovieDetails(id);
}
