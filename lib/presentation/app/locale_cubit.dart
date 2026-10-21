import 'package:equatable/equatable.dart';
import 'package:flutter_base_project/data/models/enum/language_type.dart';
import 'package:flutter_base_project/presentation/widgets/cubit/base_cubit.dart';
import 'package:flutter_base_project/domain/usecases/settings/get_language_code_use_case.dart';
import 'package:flutter_base_project/domain/usecases/settings/set_language_code_use_case.dart';
part 'locale_state.dart';

class LocaleCubit extends BaseCubit<LocaleState> {
  final SetLanguageCodeUseCase _setLanguageCode;

  LocaleCubit({
    required GetLanguageCodeUseCase getLanguageCode,
    required SetLanguageCodeUseCase setLanguageCode,
  }) : _setLanguageCode = setLanguageCode,
       super(_loadInitialState(getLanguageCode));

  static LocaleState _loadInitialState(GetLanguageCodeUseCase getLanguageCode) {
    final languageCode = getLanguageCode();
    return LocaleState(locale: LanguageType.fromString(languageCode));
  }

  void toggleLocale() {
    final currentLocale = state.locale;
    final newLocale = currentLocale == LanguageType.en
        ? LanguageType.vi
        : LanguageType.en;
    _setLanguageCode(newLocale.value);
    safeEmit(state.copyWith(locale: newLocale));
  }
}
