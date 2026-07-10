import 'package:flutter_base_project/ui/pages/detail/navigator/movie_detail_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_project/data/models/enum/load_status.dart';
import 'package:flutter_base_project/data/repositories/movie_repository.dart';
import 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final MovieRepository repository;
  final MovieDetailNavigator navigator;

  MovieDetailCubit({required this.repository, required this.navigator})
    : super(const MovieDetailState());

  Future<void> fetchMovieDetails(int id) async {
    emit(state.copyWith(fetchMovieDetailsStatus: LoadStatus.loading));
    final result = await repository.getMovieDetails(id);
    result.fold(
      ifLeft: (failure) =>
          emit(state.copyWith(fetchMovieDetailsStatus: LoadStatus.failure)),
      ifRight: (movie) => emit(
        state.copyWith(
          fetchMovieDetailsStatus: LoadStatus.success,
          movie: movie,
        ),
      ),
    );
  }
}
