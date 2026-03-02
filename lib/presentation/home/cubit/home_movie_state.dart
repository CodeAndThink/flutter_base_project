import 'package:equatable/equatable.dart';
import '../../../../domain/entities/movie.dart';

abstract class HomeMovieState extends Equatable {
  const HomeMovieState();

  @override
  List<Object> get props => [];
}

class HomeMovieInitial extends HomeMovieState {}

class HomeMovieLoading extends HomeMovieState {}

class HomeMovieLoaded extends HomeMovieState {
  final List<Movie> movies;

  const HomeMovieLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class HomeMovieError extends HomeMovieState {
  final String message;

  const HomeMovieError(this.message);

  @override
  List<Object> get props => [message];
}
