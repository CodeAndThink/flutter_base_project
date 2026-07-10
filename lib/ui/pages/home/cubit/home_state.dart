import 'package:equatable/equatable.dart';
import 'package:flutter_base_project/data/models/entities/movie.dart';
import 'package:flutter_base_project/data/models/enum/load_status.dart';

class HomeState extends Equatable {
  //LoadStatus
  final LoadStatus fetchPopularMoviesStatus;

  //Data
  final List<Movie> movies;

  const HomeState({
    this.fetchPopularMoviesStatus = LoadStatus.initial,
    this.movies = const [],
  });

  @override
  List<Object> get props => [fetchPopularMoviesStatus, movies];

  HomeState copyWith({
    LoadStatus? fetchPopularMoviesStatus,
    List<Movie>? movies,
  }) {
    return HomeState(
      fetchPopularMoviesStatus:
          fetchPopularMoviesStatus ?? this.fetchPopularMoviesStatus,
      movies: movies ?? this.movies,
    );
  }
}
