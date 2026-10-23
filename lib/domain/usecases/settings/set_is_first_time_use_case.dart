import 'package:flutter_base_project/data/repositories/settings_repository.dart';

class SetIsFirstTimeUseCase {
  final SettingsRepository _repository;
  const SetIsFirstTimeUseCase(this._repository);
  Future<void> call(bool value) => _repository.setIsFirstTime(value);
}
