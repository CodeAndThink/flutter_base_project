import 'package:flutter_base_project/data/repositories/settings_repository.dart';

class SetLanguageCodeUseCase {
  final SettingsRepository _repository;
  const SetLanguageCodeUseCase(this._repository);
  Future<void> call(String value) => _repository.setLanguageCode(value);
}
