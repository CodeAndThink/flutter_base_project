import 'package:equatable/equatable.dart';
import 'package:flutter_base_project/data/models/enum/language_type.dart';
import 'package:flutter_base_project/presentation/widgets/cubit/base_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'locale_state.dart';

class LocaleCubit extends BaseCubit<LocaleState> {
  final SharedPreferences _prefs;

  LocaleCubit(this._prefs) : super(_loadInitialState(_prefs));

  static LocaleState _loadInitialState(SharedPreferences prefs) {
    final languageCode = prefs.getString('language_code') ?? 'en';
    return LocaleState(locale: LanguageType.fromString(languageCode));
  }

  void toggleLocale() {
    final currentLocale = state.locale;
    final newLocale = currentLocale == LanguageType.en
        ? LanguageType.vi
        : LanguageType.en;
    _prefs.setString('language_code', newLocale.value);
    safeEmit(state.copyWith(locale: newLocale));
  }
}
