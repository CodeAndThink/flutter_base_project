// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(message) => "Error: ${message}";

  static String m1(date) => "Release: ${date}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "commonBack": MessageLookupByLibrary.simpleMessage("Back"),
    "commonCameraPermissionDenied": MessageLookupByLibrary.simpleMessage(
      "Camera access denied or device has no camera.",
    ),
    "commonCameraPermissionDescription": MessageLookupByLibrary.simpleMessage(
      "App needs access to your camera to take photos.",
    ),
    "commonCameraPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "Camera Permission Required",
    ),
    "commonCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "commonConfirmPassword": MessageLookupByLibrary.simpleMessage(
      "Confirm Password",
    ),
    "commonDelete": MessageLookupByLibrary.simpleMessage("Delete"),
    "commonEmail": MessageLookupByLibrary.simpleMessage("Email"),
    "commonError": m0,
    "commonErrorPrefix": MessageLookupByLibrary.simpleMessage("Error"),
    "commonErrorSomethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "An unexpected error occurred. Please try again later.",
    ),
    "commonFinish": MessageLookupByLibrary.simpleMessage("Finish"),
    "commonLanguage": MessageLookupByLibrary.simpleMessage("Language"),
    "commonLogin": MessageLookupByLibrary.simpleMessage("Login"),
    "commonLogout": MessageLookupByLibrary.simpleMessage("Log out"),
    "commonNext": MessageLookupByLibrary.simpleMessage("Next"),
    "commonOk": MessageLookupByLibrary.simpleMessage("OK"),
    "commonPassword": MessageLookupByLibrary.simpleMessage("Password"),
    "commonPermissionDescription": MessageLookupByLibrary.simpleMessage(
      "App needs access to your photo library to select photos.",
    ),
    "commonPermissionRequired": MessageLookupByLibrary.simpleMessage(
      "Photo Library Permission Required",
    ),
    "commonRegister": MessageLookupByLibrary.simpleMessage("Register"),
    "commonReset": MessageLookupByLibrary.simpleMessage("Reset"),
    "commonRetry": MessageLookupByLibrary.simpleMessage("Retry"),
    "commonSave": MessageLookupByLibrary.simpleMessage("Save"),
    "commonSettings": MessageLookupByLibrary.simpleMessage("Settings"),
    "commonSkip": MessageLookupByLibrary.simpleMessage("Skip"),
    "commonSubmit": MessageLookupByLibrary.simpleMessage("Submit"),
    "commonSuccess": MessageLookupByLibrary.simpleMessage("Success"),
    "commonTheme": MessageLookupByLibrary.simpleMessage("Theme"),
    "commonThemeDark": MessageLookupByLibrary.simpleMessage("Dark"),
    "commonThemeLight": MessageLookupByLibrary.simpleMessage("Light"),
    "commonThemeSystem": MessageLookupByLibrary.simpleMessage("System"),
    "commonUnknown": MessageLookupByLibrary.simpleMessage("Unknown"),
    "detailNoOverviewAvailable": MessageLookupByLibrary.simpleMessage(
      "No overview available.",
    ),
    "detailOverview": MessageLookupByLibrary.simpleMessage("Overview"),
    "detailRelease": m1,
    "homePopularMovies": MessageLookupByLibrary.simpleMessage("Popular Movies"),
    "onboardingDesc1": MessageLookupByLibrary.simpleMessage(
      "This is a clean architecture boilerplate.",
    ),
    "onboardingDesc2": MessageLookupByLibrary.simpleMessage(
      "Powered by flutter_bloc for predictable states.",
    ),
    "onboardingDesc3": MessageLookupByLibrary.simpleMessage(
      "Ready to build awesome apps?",
    ),
    "onboardingGetStarted": MessageLookupByLibrary.simpleMessage("Get Started"),
    "onboardingStateManagement": MessageLookupByLibrary.simpleMessage(
      "State Management",
    ),
    "onboardingWelcome": MessageLookupByLibrary.simpleMessage("Welcome"),
  };
}
