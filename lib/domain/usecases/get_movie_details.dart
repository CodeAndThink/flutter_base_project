import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetMovieDetails {
  final MovieRepository repository;

  GetMovieDetails(this.repository);

  Future<Movie> execute(int id) async {
    return await repository.getMovieDetails(id);
  }
}
