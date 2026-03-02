import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_remote_data_source.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Movie>> getPopularMovies() async {
    try {
      return await remoteDataSource.getPopularMovies();
    } catch (e) {
      // Typically you would handle exceptions and map them to domain Failures here.
      // E.g., using fpdart's Either. For simplicity, just rethrowing.
      rethrow;
    }
  }

  @override
  Future<Movie> getMovieDetails(int id) async {
    try {
      return await remoteDataSource.getMovieDetails(id);
    } catch (e) {
      rethrow;
    }
  }
}
