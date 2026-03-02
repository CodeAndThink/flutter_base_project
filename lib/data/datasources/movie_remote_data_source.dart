import 'package:dio/dio.dart';
import '../../core/network/api_clients.dart';
import '../models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getPopularMovies();
  Future<MovieModel> getMovieDetails(int id);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final ApiClients apiClient;

  MovieRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    try {
      final response = await apiClient.getPopularMovies();
      return response.results ?? [];
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Dio Exception occurred');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<MovieModel> getMovieDetails(int id) async {
    try {
      return await apiClient.getMovieDetails(id);
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Dio Exception occurred');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
