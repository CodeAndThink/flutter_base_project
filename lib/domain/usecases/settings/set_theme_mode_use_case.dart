import 'package:flutter_base_project/data/repositories/settings_repository.dart';

class SetThemeModeUseCase {
  final SettingsRepository _repository;
  const SetThemeModeUseCase(this._repository);
  Future<void> call(int value) => _repository.setThemeMode(value);
}
