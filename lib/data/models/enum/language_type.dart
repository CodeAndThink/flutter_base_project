enum LanguageType {
  en,
  vi;

  bool get isEnglish => this == LanguageType.en;
  bool get isVietnamese => this == LanguageType.vi;

  String get locale {
    switch (this) {
      case LanguageType.en:
        return 'en_US';
      case LanguageType.vi:
        return 'vi_VN';
    }
  }

  String get name {
    switch (this) {
      case LanguageType.en:
        return 'English';
      case LanguageType.vi:
        return 'Tiếng Việt';
    }
  }

  String get value {
    switch (this) {
      case LanguageType.en:
        return 'en';
      case LanguageType.vi:
        return 'vi';
    }
  }

  String get flag {
    switch (this) {
      case LanguageType.en:
        return '🇺🇸';
      case LanguageType.vi:
        return '🇻🇳';
    }
  }

  static LanguageType fromString(String value) {
    return LanguageType.values.firstWhere(
      (e) => e.name == value || e.value == value,
      orElse: () => LanguageType.en,
    );
  }
}
