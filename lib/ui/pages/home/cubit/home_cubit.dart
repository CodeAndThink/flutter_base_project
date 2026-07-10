import 'package:flutter_base_project/data/models/enum/load_status.dart';
import 'package:flutter_base_project/data/repositories/onboarding_repository.dart';
import 'package:flutter_base_project/ui/pages/detail/page/movie_detail_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_project/data/repositories/movie_repository.dart';
import 'home_state.dart';
import 'package:flutter_base_project/ui/pages/home/navigator/home_navigator.dart';

class HomeCubit extends Cubit<HomeState> {
  final MovieRepository repository;
  final HomeNavigator navigator;
  final OnboardingRepository onboardingRepository;

  HomeCubit({
    required this.repository,
    required this.navigator,
    required this.onboardingRepository,
  }) : super(const HomeState());

  Future<void> resetOnboarding() async {
    await onboardingRepository.clearOnboarding();
  }

  Future<void> fetchPopularMovies() async {
    emit(state.copyWith(fetchPopularMoviesStatus: LoadStatus.loading));
    final result = await repository.getPopularMovies();
    result.fold(
      ifLeft: (failure) =>
          emit(state.copyWith(fetchPopularMoviesStatus: LoadStatus.failure)),
      ifRight: (movies) => emit(
        state.copyWith(
          fetchPopularMoviesStatus: LoadStatus.success,
          movies: movies,
        ),
      ),
    );
  }

  ///Navigator Methods
  void openMovieDetail({required int movieId}) {
    navigator.openMovieDetail(args: MovieDetailArgument(movieId: movieId));
  }
}
