import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_base_project/router/app_router.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        if (context.canPop()) {
          context.pop();
        } else {
          // Fallback to home if directly loaded without history
          context.go(AppRouter.homePath);
        }
      },
    );
  }
}
