import '../../core/network/dio_client.dart';
import '../models/movie_model.dart';
import 'package:dio/dio.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getPopularMovies();
  Future<MovieModel> getMovieDetails(int id);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final DioClient dioClient;

  MovieRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    try {
      final response = await dioClient.dio.get('/movie/popular');
      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'];
        return results.map((json) => MovieModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load popular movies');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Dio Exception occurred');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<MovieModel> getMovieDetails(int id) async {
    try {
      final response = await dioClient.dio.get('/movie/$id');
      if (response.statusCode == 200) {
        return MovieModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load movie details');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Dio Exception occurred');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
