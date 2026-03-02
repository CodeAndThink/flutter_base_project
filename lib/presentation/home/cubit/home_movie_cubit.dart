import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/usecases/get_popular_movies.dart';
import 'home_movie_state.dart';

class HomeMovieCubit extends Cubit<HomeMovieState> {
  final GetPopularMovies getPopularMovies;

  HomeMovieCubit({required this.getPopularMovies}) : super(HomeMovieInitial());

  Future<void> fetchPopularMovies() async {
    emit(HomeMovieLoading());
    try {
      final movies = await getPopularMovies.execute();
      emit(HomeMovieLoaded(movies));
    } catch (e) {
      emit(HomeMovieError(e.toString()));
    }
  }
}
