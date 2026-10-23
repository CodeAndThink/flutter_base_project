import 'package:flutter_base_project/data/repositories/settings_repository.dart';

class SetSoundEnabledUseCase {
  final SettingsRepository _repository;
  const SetSoundEnabledUseCase(this._repository);
  Future<void> call(bool value) => _repository.setSoundEnabled(value);
}
