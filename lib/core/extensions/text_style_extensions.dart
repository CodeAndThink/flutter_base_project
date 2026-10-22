import 'package:flutter/material.dart';
import 'package:flutter_base_project/presentation/theme/app_text_styles.dart';

extension TextStyleExtensions on BuildContext {
  /// Typography from the nearest theme, updated when that theme changes.
  AppTextStyles get textStyles => AppTextStyles(Theme.of(this).textTheme);
}
