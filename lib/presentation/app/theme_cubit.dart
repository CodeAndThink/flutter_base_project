import 'package:flutter/material.dart';
import 'package:flutter_base_project/presentation/app/theme_state.dart';
import 'package:flutter_base_project/presentation/widgets/cubit/base_cubit.dart';
import 'package:flutter_base_project/domain/usecases/settings/get_theme_mode_use_case.dart';
import 'package:flutter_base_project/domain/usecases/settings/set_theme_mode_use_case.dart';

class ThemeCubit extends BaseCubit<ThemeState> {
  final SetThemeModeUseCase _setThemeMode;

  ThemeCubit({
    required GetThemeModeUseCase getThemeMode,
    required SetThemeModeUseCase setThemeMode,
  }) : _setThemeMode = setThemeMode,
       super(_loadInitialState(getThemeMode));

  static ThemeState _loadInitialState(GetThemeModeUseCase getThemeMode) {
    final themeIndex = getThemeMode();

    return ThemeState(themeMode: ThemeMode.values[themeIndex]);
  }

  void updateTheme({required ThemeMode mode}) {
    _setThemeMode(mode.index);
    safeEmit(state.copyWith(themeMode: mode));
  }

  void toggleTheme() {
    if (state.themeMode == ThemeMode.light) {
      updateTheme(mode: ThemeMode.dark);
    } else {
      updateTheme(mode: ThemeMode.light);
    }
  }
}
