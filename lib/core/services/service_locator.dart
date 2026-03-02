import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/local_storage_datasource.dart';
import '../../data/repositories/onboarding_repository_impl.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../../domain/usecases/check_onboarding_status.dart';
import '../../domain/usecases/clear_onboarding_status.dart';
import '../../domain/usecases/save_onboarding_status.dart';
import '../../presentation/home/cubit/home_cubit.dart';
import '../../presentation/onboarding/bloc/onboarding_bloc.dart';

// Movie imports
import '../network/dio_client.dart';
import '../../data/datasources/movie_remote_data_source.dart';
import '../../data/repositories/movie_repository_impl.dart';
import '../../domain/repositories/movie_repository.dart';
import '../../domain/usecases/get_popular_movies.dart';
import '../../domain/usecases/get_movie_details.dart';
import '../../presentation/home/cubit/home_movie_cubit.dart';
import '../../presentation/detail/cubit/movie_detail_cubit.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Data sources
  sl.registerLazySingleton<LocalStorageDataSource>(
    () => LocalStorageDataSourceImpl(sharedPreferences: sl()),
  );

  // Repository
  sl.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(localDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => CheckOnboardingStatus(repository: sl()));
  sl.registerLazySingleton(() => SaveOnboardingStatus(repository: sl()));
  sl.registerLazySingleton(() => ClearOnboardingStatus(repository: sl()));

  // Blocs
  sl.registerFactory(
    () =>
        OnboardingBloc(checkOnboardingStatus: sl(), saveOnboardingStatus: sl()),
  );
  sl.registerFactory(() => HomeCubit(clearOnboardingStatus: sl()));

  // Setup Movie Dependencies
  _setupMovieDependencies();
}

void _setupMovieDependencies() {
  // Network
  sl.registerLazySingleton<DioClient>(() => DioClient());

  // Data sources
  sl.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(dioClient: sl()),
  );

  // Repository
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetPopularMovies(sl()));
  sl.registerLazySingleton(() => GetMovieDetails(sl()));

  // Blocs
  sl.registerFactory(() => HomeMovieCubit(getPopularMovies: sl()));
  sl.registerFactory(() => MovieDetailCubit(getMovieDetails: sl()));
}
