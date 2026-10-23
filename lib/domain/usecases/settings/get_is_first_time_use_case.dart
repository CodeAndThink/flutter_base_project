import 'package:flutter_base_project/data/repositories/settings_repository.dart';

class GetIsFirstTimeUseCase {
  final SettingsRepository _repository;
  const GetIsFirstTimeUseCase(this._repository);
  bool call() => _repository.getIsFirstTime();
}
