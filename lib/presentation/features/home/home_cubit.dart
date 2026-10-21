import 'package:flutter_base_project/data/models/enum/load_status.dart';
import 'package:flutter_base_project/domain/usecases/onboarding/clear_onboarding_use_case.dart';
import 'package:flutter_base_project/presentation/features/detail/movie_detail_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_project/domain/usecases/movie/get_popular_movies_use_case.dart';
import 'home_state.dart';
import 'package:flutter_base_project/presentation/features/home/home_navigator.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetPopularMoviesUseCase getPopularMovies;
  final HomeNavigator navigator;
  final ClearOnboardingUseCase clearOnboarding;

  HomeCubit({
    required this.getPopularMovies,
    required this.navigator,
    required this.clearOnboarding,
  }) : super(const HomeState());

  Future<void> resetOnboarding() async {
    await clearOnboarding();
  }

  Future<void> fetchPopularMovies() async {
    emit(state.copyWith(fetchPopularMoviesStatus: LoadStatus.loading));
    final result = await getPopularMovies();
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
