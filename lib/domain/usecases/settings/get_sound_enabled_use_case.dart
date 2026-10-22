import 'package:flutter_base_project/data/repositories/settings_repository.dart';

class GetSoundEnabledUseCase {
  final SettingsRepository _repository;
  const GetSoundEnabledUseCase(this._repository);
  bool call() => _repository.getSoundEnabled();
}
