import 'package:flutter/material.dart';
import '../appbars/custom_app_bar.dart';

class AppScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final PreferredSizeWidget? appBar;
  final List<Widget>? actions;

  const AppScaffold({
    super.key,
    this.title,
    required this.body,
    this.appBar,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          appBar ??
          (title != null
              ? CustomAppBar(title: title!, actions: actions)
              : null),
      body: body,
    );
  }
}
