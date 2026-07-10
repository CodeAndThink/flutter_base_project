// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Back`
  String get commonBack {
    return Intl.message('Back', name: 'commonBack', desc: '', args: []);
  }

  /// `Camera access denied or device has no camera.`
  String get commonCameraPermissionDenied {
    return Intl.message(
      'Camera access denied or device has no camera.',
      name: 'commonCameraPermissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `App needs access to your camera to take photos.`
  String get commonCameraPermissionDescription {
    return Intl.message(
      'App needs access to your camera to take photos.',
      name: 'commonCameraPermissionDescription',
      desc: '',
      args: [],
    );
  }

  /// `Camera Permission Required`
  String get commonCameraPermissionRequired {
    return Intl.message(
      'Camera Permission Required',
      name: 'commonCameraPermissionRequired',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get commonCancel {
    return Intl.message('Cancel', name: 'commonCancel', desc: '', args: []);
  }

  /// `Confirm Password`
  String get commonConfirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'commonConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get commonDelete {
    return Intl.message('Delete', name: 'commonDelete', desc: '', args: []);
  }

  /// `Email`
  String get commonEmail {
    return Intl.message('Email', name: 'commonEmail', desc: '', args: []);
  }

  /// `Error: {message}`
  String commonError(Object message) {
    return Intl.message(
      'Error: $message',
      name: 'commonError',
      desc: '',
      args: [message],
    );
  }

  /// `Error`
  String get commonErrorPrefix {
    return Intl.message('Error', name: 'commonErrorPrefix', desc: '', args: []);
  }

  /// `An unexpected error occurred. Please try again later.`
  String get commonErrorSomethingWentWrong {
    return Intl.message(
      'An unexpected error occurred. Please try again later.',
      name: 'commonErrorSomethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get commonFinish {
    return Intl.message('Finish', name: 'commonFinish', desc: '', args: []);
  }

  /// `Language`
  String get commonLanguage {
    return Intl.message('Language', name: 'commonLanguage', desc: '', args: []);
  }

  /// `Login`
  String get commonLogin {
    return Intl.message('Login', name: 'commonLogin', desc: '', args: []);
  }

  /// `Log out`
  String get commonLogout {
    return Intl.message('Log out', name: 'commonLogout', desc: '', args: []);
  }

  /// `Next`
  String get commonNext {
    return Intl.message('Next', name: 'commonNext', desc: '', args: []);
  }

  /// `OK`
  String get commonOk {
    return Intl.message('OK', name: 'commonOk', desc: '', args: []);
  }

  /// `Password`
  String get commonPassword {
    return Intl.message('Password', name: 'commonPassword', desc: '', args: []);
  }

  /// `App needs access to your photo library to select photos.`
  String get commonPermissionDescription {
    return Intl.message(
      'App needs access to your photo library to select photos.',
      name: 'commonPermissionDescription',
      desc: '',
      args: [],
    );
  }

  /// `Photo Library Permission Required`
  String get commonPermissionRequired {
    return Intl.message(
      'Photo Library Permission Required',
      name: 'commonPermissionRequired',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get commonRegister {
    return Intl.message('Register', name: 'commonRegister', desc: '', args: []);
  }

  /// `Reset`
  String get commonReset {
    return Intl.message('Reset', name: 'commonReset', desc: '', args: []);
  }

  /// `Retry`
  String get commonRetry {
    return Intl.message('Retry', name: 'commonRetry', desc: '', args: []);
  }

  /// `Save`
  String get commonSave {
    return Intl.message('Save', name: 'commonSave', desc: '', args: []);
  }

  /// `Settings`
  String get commonSettings {
    return Intl.message('Settings', name: 'commonSettings', desc: '', args: []);
  }

  /// `Submit`
  String get commonSubmit {
    return Intl.message('Submit', name: 'commonSubmit', desc: '', args: []);
  }

  /// `Success`
  String get commonSuccess {
    return Intl.message('Success', name: 'commonSuccess', desc: '', args: []);
  }

  /// `Theme`
  String get commonTheme {
    return Intl.message('Theme', name: 'commonTheme', desc: '', args: []);
  }

  /// `Dark`
  String get commonThemeDark {
    return Intl.message('Dark', name: 'commonThemeDark', desc: '', args: []);
  }

  /// `Light`
  String get commonThemeLight {
    return Intl.message('Light', name: 'commonThemeLight', desc: '', args: []);
  }

  /// `System`
  String get commonThemeSystem {
    return Intl.message(
      'System',
      name: 'commonThemeSystem',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get commonSkip {
    return Intl.message('Skip', name: 'commonSkip', desc: '', args: []);
  }

  /// `Unknown`
  String get commonUnknown {
    return Intl.message('Unknown', name: 'commonUnknown', desc: '', args: []);
  }

  /// `Popular Movies`
  String get homePopularMovies {
    return Intl.message(
      'Popular Movies',
      name: 'homePopularMovies',
      desc: '',
      args: [],
    );
  }

  /// `Release: {date}`
  String detailRelease(Object date) {
    return Intl.message(
      'Release: $date',
      name: 'detailRelease',
      desc: '',
      args: [date],
    );
  }

  /// `Overview`
  String get detailOverview {
    return Intl.message('Overview', name: 'detailOverview', desc: '', args: []);
  }

  /// `No overview available.`
  String get detailNoOverviewAvailable {
    return Intl.message(
      'No overview available.',
      name: 'detailNoOverviewAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get onboardingWelcome {
    return Intl.message(
      'Welcome',
      name: 'onboardingWelcome',
      desc: '',
      args: [],
    );
  }

  /// `This is a clean architecture boilerplate.`
  String get onboardingDesc1 {
    return Intl.message(
      'This is a clean architecture boilerplate.',
      name: 'onboardingDesc1',
      desc: '',
      args: [],
    );
  }

  /// `State Management`
  String get onboardingStateManagement {
    return Intl.message(
      'State Management',
      name: 'onboardingStateManagement',
      desc: '',
      args: [],
    );
  }

  /// `Powered by flutter_bloc for predictable states.`
  String get onboardingDesc2 {
    return Intl.message(
      'Powered by flutter_bloc for predictable states.',
      name: 'onboardingDesc2',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get onboardingGetStarted {
    return Intl.message(
      'Get Started',
      name: 'onboardingGetStarted',
      desc: '',
      args: [],
    );
  }

  /// `Ready to build awesome apps?`
  String get onboardingDesc3 {
    return Intl.message(
      'Ready to build awesome apps?',
      name: 'onboardingDesc3',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
