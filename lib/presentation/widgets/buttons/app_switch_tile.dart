import 'package:flutter_base_project/core/extensions/text_style_extensions.dart';
import 'package:flutter/material.dart';

class AppSwitchTile extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? secondary;
  final Widget? subtitle;

  const AppSwitchTile({
    super.key,
    required this.title,
    required this.value,
    this.onChanged,
    this.titleStyle,
    this.contentPadding = EdgeInsets.zero,
    this.secondary,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: titleStyle ?? context.textStyles.bodyMedium),
        Switch(value: value, onChanged: onChanged),
      ],
    );
  }
}
