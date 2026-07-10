part of 'locale_cubit.dart';

class LocaleState extends Equatable {
  final LanguageType locale;

  const LocaleState({this.locale = LanguageType.en});

  @override
  List<Object?> get props => [locale];

  LocaleState copyWith({LanguageType? locale}) {
    return LocaleState(locale: locale ?? this.locale);
  }
}
