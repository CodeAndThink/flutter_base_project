import 'package:flutter_base_project/data/repositories/settings_repository.dart';

class GetLanguageCodeUseCase {
  final SettingsRepository _repository;
  const GetLanguageCodeUseCase(this._repository);
  String call() => _repository.getLanguageCode();
}
