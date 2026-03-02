import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/usecases/get_movie_details.dart';
import 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final GetMovieDetails getMovieDetails;

  MovieDetailCubit({required this.getMovieDetails})
    : super(MovieDetailInitial());

  Future<void> fetchMovieDetails(int id) async {
    emit(MovieDetailLoading());
    try {
      final movie = await getMovieDetails.execute(id);
      emit(MovieDetailLoaded(movie));
    } catch (e) {
      emit(MovieDetailError(e.toString()));
    }
  }
}
