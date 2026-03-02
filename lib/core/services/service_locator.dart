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
}
