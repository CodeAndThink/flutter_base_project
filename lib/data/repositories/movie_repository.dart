import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';
import 'package:flutter_base_project/core/failure/app_failure.dart';
import 'package:flutter_base_project/core/network/api_clients.dart';
import 'package:flutter_base_project/data/models/response/movie_model.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieModel>>> getPopularMovies();
  Future<Either<Failure, MovieModel>> getMovieDetails(int id);
}

class MovieRepositoryImpl implements MovieRepository {
  final ApiClients apiClient;

  MovieRepositoryImpl({required this.apiClient});

  @override
  Future<Either<Failure, List<MovieModel>>> getPopularMovies() async {
    try {
      final response = await apiClient.getPopularMovies();
      return Right(response.results ?? []);
    } on DioException catch (e) {
      return Left(mapExceptionToFailure(e));
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, MovieModel>> getMovieDetails(int id) async {
    try {
      final result = await apiClient.getMovieDetails(id);
      return Right(result);
    } on DioException catch (e) {
      return Left(mapExceptionToFailure(e));
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
