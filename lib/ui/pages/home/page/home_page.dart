import 'package:flutter/material.dart';
import 'package:flutter_base_project/data/repositories/onboarding_repository.dart';
import 'package:flutter_base_project/ui/pages/home/navigator/home_navigator.dart';
import 'package:flutter_base_project/ui/pages/home/widgets/home_list_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_project/ui/widgets/buttons/theme_toggle_button.dart';
import 'package:flutter_base_project/ui/widgets/scaffold/app_scaffold.dart';
import 'package:flutter_base_project/ui/pages/home/cubit/home_cubit.dart';
import 'package:flutter_base_project/ui/pages/home/cubit/home_state.dart';
import 'package:flutter_base_project/data/repositories/movie_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        repository: context.read<MovieRepository>(),
        onboardingRepository: context.read<OnboardingRepository>(),
        navigator: HomeNavigator(context: context),
      ),
      child: const HomeChildPage(),
    );
  }
}

class HomeChildPage extends StatefulWidget {
  const HomeChildPage({super.key});

  @override
  State<HomeChildPage> createState() => _HomeChildPageState();
}

class _HomeChildPageState extends State<HomeChildPage> {
  late final HomeCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<HomeCubit>();
    _cubit.fetchPopularMovies();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Popular Movies',
      actions: const [ThemeToggleButton(), SizedBox(width: 8)],
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.fetchPopularMoviesStatus.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.fetchPopularMoviesStatus.isFailure) {
          return Center(child: Text('Error'));
        } else if (state.fetchPopularMoviesStatus.isSuccess) {
          final movies = state.movies;
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return HomeListItem(
                movie: movie,
                onTap: () {
                  if (movie.id != null) {
                    _cubit.openMovieDetail(movieId: movie.id!);
                  }
                },
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
