import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_base_project/core/services/connection_service.dart';
import 'package:flutter_base_project/presentation/widgets/cubit/base_cubit.dart';
import 'package:flutter_base_project/domain/usecases/settings/get_is_first_time_use_case.dart';
import 'package:flutter_base_project/domain/usecases/settings/set_is_first_time_use_case.dart';

part 'app_state.dart';

class AppCubit extends BaseCubit<AppState> {
  final ConnectionService _connectionService;
  final GetIsFirstTimeUseCase _getIsFirstTime;
  final SetIsFirstTimeUseCase _setIsFirstTime;

  AppCubit(
    this._connectionService, {
    required GetIsFirstTimeUseCase getIsFirstTime,
    required SetIsFirstTimeUseCase setIsFirstTime,
  }) : _getIsFirstTime = getIsFirstTime,
       _setIsFirstTime = setIsFirstTime,
       super(const AppState()) {
    _init();
  }

  Future<void> _init() async {
    // Start connection monitoring service
    _connectionService.init();

    final isFirstTime = _getIsFirstTime();
    safeEmit(state.copyWith(isFirstTime: isFirstTime));
  }

  Future<void> completeOnboarding() async {
    await _setIsFirstTime(false);
    safeEmit(state.copyWith(isFirstTime: false));
  }

  @override
  Future<void> close() {
    _connectionService.dispose();
    return super.close();
  }
}
