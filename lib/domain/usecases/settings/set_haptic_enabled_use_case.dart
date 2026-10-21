import 'package:flutter_base_project/data/repositories/settings_repository.dart';

class SetHapticEnabledUseCase {
  final SettingsRepository _repository;
  const SetHapticEnabledUseCase(this._repository);
  Future<void> call(bool value) => _repository.setHapticEnabled(value);
}
