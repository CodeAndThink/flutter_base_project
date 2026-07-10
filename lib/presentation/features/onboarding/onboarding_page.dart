import 'package:flutter/material.dart';
import 'package:flutter_base_project/core/constants/app_assets.dart';
import 'package:flutter_base_project/core/extensions/num_extensions.dart';
import 'package:flutter_base_project/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_project/data/models/entities/onboarding_item.dart';
import 'package:flutter_base_project/presentation/features/onboarding/onboarding_cubit.dart';
import 'package:flutter_base_project/presentation/features/onboarding/onboarding_state.dart';
import 'package:flutter_base_project/presentation/features/onboarding/onboarding_navigator.dart';
import 'package:flutter_base_project/data/repositories/onboarding_repository.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(
        repository: context.read<OnboardingRepository>(),
        navigator: OnboardingNavigator(context),
      )..checkIfOnboardingCompleted(),
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
  late ThemeData _theme;
  late S _l10n;
  late final OnboardingCubit _cubit;

  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<OnboardingCubit>();
    _pageController = PageController();
  }

  List<OnboardingItem> _getItems() {
    return [
      OnboardingItem(
        title: _l10n.onboardingWelcome,
        description: _l10n.onboardingDesc1,
        imagePath: AppAssets.image1, // Placeholder
      ),
      OnboardingItem(
        title: _l10n.onboardingStateManagement,
        description: _l10n.onboardingDesc2,
        imagePath: AppAssets.image2, // Placeholder
      ),
      OnboardingItem(
        title: _l10n.onboardingGetStarted,
        description: _l10n.onboardingDesc3,
        imagePath: AppAssets.image3,
      ),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    _l10n = S.of(context);
    final items = _getItems();
    return Scaffold(
      body: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          if (state.loadStatus.isLoading || state.loadStatus.isInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.loadStatus.isSuccess) {
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
                        _cubit.pageChanged(index);
                      },
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: 40.paddingAll,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                items[index].imagePath,
                                height: 250,
                                fit: BoxFit.contain,
                              ),
                              32.height,
                              Text(
                                items[index].title,
                                style: _theme.textTheme.headlineMedium,
                                textAlign: TextAlign.center,
                              ),
                              16.height,
                              Text(
                                items[index].description,
                                style: _theme.textTheme.bodyLarge,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: 24.paddingAll,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Skip Button
                        TextButton(
                          onPressed: () {
                            _cubit.completeOnboarding();
                          },
                          child: Text(_l10n.commonSkip),
                        ),
                        // Indicators (Simple representation)
                        Row(
                          children: List.generate(
                            items.length,
                            (index) => Container(
                              margin: 4.paddingHorizontal,
                              width: state.currentPage == index ? 12 : 8,
                              height: state.currentPage == index ? 12 : 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: state.currentPage == index
                                    ? _theme.primaryColor
                                    : Colors.grey.shade300,
                              ),
                            ),
                          ),
                        ),
                        // Next/Done Button
                        ElevatedButton(
                          onPressed: () {
                            if (state.currentPage == items.length - 1) {
                              _cubit.completeOnboarding();
                            } else {
                              _pageController.nextPage(
                                duration: 300.milliseconds,
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          child: Text(
                            state.currentPage == items.length - 1
                                ? _l10n.commonFinish
                                : _l10n.commonNext,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          if (state.loadStatus.isFailure) {
            return Center(child: Text(_l10n.commonErrorPrefix));
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}
