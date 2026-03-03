import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_base_project/data/models/entities/onboarding_item.dart';
import 'package:flutter_base_project/ui/pages/onboarding/bloc/onboarding_bloc.dart';
import 'package:flutter_base_project/ui/pages/onboarding/bloc/onboarding_event.dart';
import 'package:flutter_base_project/ui/pages/onboarding/bloc/onboarding_state.dart';
import 'package:flutter_base_project/data/repositories/onboarding_repository.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OnboardingBloc(repository: context.read<OnboardingRepository>())
            ..add(CheckIfOnboardingCompleted()),
      child: const OnboardingView(),
    );
  }
}

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();

  final List<OnboardingItem> items = [
    const OnboardingItem(
      title: 'Welcome',
      description: 'This is a clean architecture boilerplate.',
      imagePath: 'assets/image1.png', // Placeholder
    ),
    const OnboardingItem(
      title: 'State Management',
      description: 'Powered by flutter_bloc for predictable states.',
      imagePath: 'assets/image2.png', // Placeholder
    ),
    const OnboardingItem(
      title: 'Get Started',
      description: 'Ready to build awesome apps?',
      imagePath: 'assets/image3.png', // Placeholder
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingLoaded && state.hasCompleted) {
            context.go('/home');
          }
        },
        builder: (context, state) {
          if (state is OnboardingLoading || state is OnboardingInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is OnboardingLoaded) {
            // If already completed but listener hasn't fired yet, show empty or loading
            if (state.hasCompleted) {
              return const SizedBox();
            }

            return SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: items.length,
                      onPageChanged: (index) {
                        context.read<OnboardingBloc>().add(PageChanged(index));
                      },
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Placeholder for actual image
                              const Icon(
                                Icons.image,
                                size: 100,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 32),
                              Text(
                                items[index].title,
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineMedium,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                items[index].description,
                                style: Theme.of(context).textTheme.bodyLarge,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Skip Button
                        TextButton(
                          onPressed: () {
                            context.read<OnboardingBloc>().add(
                              CompleteOnboarding(),
                            );
                          },
                          child: const Text('Skip'),
                        ),
                        // Indicators (Simple representation)
                        Row(
                          children: List.generate(
                            items.length,
                            (index) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: state.currentPage == index ? 12 : 8,
                              height: state.currentPage == index ? 12 : 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: state.currentPage == index
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey.shade300,
                              ),
                            ),
                          ),
                        ),
                        // Next/Done Button
                        ElevatedButton(
                          onPressed: () {
                            if (state.currentPage == items.length - 1) {
                              context.read<OnboardingBloc>().add(
                                CompleteOnboarding(),
                              );
                            } else {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          child: Text(
                            state.currentPage == items.length - 1
                                ? 'Done'
                                : 'Next',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is OnboardingError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox();
        },
      ),
    );
  }
}
