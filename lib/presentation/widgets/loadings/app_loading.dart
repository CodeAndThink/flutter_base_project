import 'package:flutter/material.dart';
import 'package:flutter_base_project/core/extensions/num_extensions.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppLoading extends StatelessWidget {
  final double size;
  final Color? loadingColor;

  const AppLoading({super.key, this.size = 40.0, this.loadingColor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = loadingColor ?? theme.colorScheme.primary;

    return Center(
      child: size.square(child: SpinKitRipple(color: color)),
    );
  }
}
