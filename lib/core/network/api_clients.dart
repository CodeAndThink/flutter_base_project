import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../data/models/movie_model.dart';
import '../../data/models/movie_response_model.dart';

part 'api_clients.g.dart';

@RestApi()
abstract class ApiClients {
  factory ApiClients(Dio dio, {String baseUrl}) = _ApiClients;

  @GET("/movie/popular")
  Future<MovieResponseModel> getPopularMovies();

  @GET("/movie/{id}")
  Future<MovieModel> getMovieDetails(@Path("id") int id);
}
