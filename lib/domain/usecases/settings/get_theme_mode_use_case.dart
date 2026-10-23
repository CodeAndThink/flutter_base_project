import 'package:flutter_base_project/data/repositories/settings_repository.dart';

class GetThemeModeUseCase {
  final SettingsRepository _repository;
  const GetThemeModeUseCase(this._repository);
  int call() => _repository.getThemeMode();
}
