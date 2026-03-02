import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/service_locator.dart';
import '../cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeCubit>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Welcome to the Home Page!'),
              const SizedBox(height: 20),
              BlocBuilder<HomeCubit, void>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () async {
                      await context.read<HomeCubit>().resetOnboarding();
                      if (context.mounted) {
                        context.go('/');
                      }
                    },
                    child: const Text('Reset Onboarding'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
