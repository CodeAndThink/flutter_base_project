import 'package:flutter_base_project/data/repositories/settings_repository.dart';

class GetHapticEnabledUseCase {
  final SettingsRepository _repository;
  const GetHapticEnabledUseCase(this._repository);
  bool call() => _repository.getHapticEnabled();
}
