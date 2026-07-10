import 'package:equatable/equatable.dart';
import 'package:flutter_base_project/data/models/entities/movie.dart';
import 'package:flutter_base_project/data/models/enum/load_status.dart';

class MovieDetailState extends Equatable {
  //Load Status
  final LoadStatus fetchMovieDetailsStatus;

  //Movie
  final Movie? movie;

  const MovieDetailState({
    this.fetchMovieDetailsStatus = LoadStatus.initial,
    this.movie,
  });

  @override
  List<Object?> get props => [fetchMovieDetailsStatus, movie];

  MovieDetailState copyWith({
    LoadStatus? fetchMovieDetailsStatus,
    Movie? movie,
  }) {
    return MovieDetailState(
      fetchMovieDetailsStatus:
          fetchMovieDetailsStatus ?? this.fetchMovieDetailsStatus,
      movie: movie ?? this.movie,
    );
  }
}
